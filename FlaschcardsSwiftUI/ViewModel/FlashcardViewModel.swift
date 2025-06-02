//
//  FlashcardViewModel.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 23.05.25.
//
import SwiftUI
import SwiftData
import Combine

class FlashcardViewModel: ObservableObject {
    
    @Published var question: String = ""
    @Published var answer: String = ""
    @Published var errorMessage: String = ""
    @Published var infoMessage: String = ""
    
    @Published var isSheetCreateNewFlashcardOpen: Bool = false
    @Published var alertDeleteFlashcardIsPresent: Bool = false
    @Published var toastMessageIfFlashcardCreated: Bool = false
    
    @Published var isFavorite: Bool = false
    
    @Published var selectedFlashcard: Flashcard?
    @Published var currentFolder: Folder?
    
    // Добавляем свойство для отслеживания изменений
    @Published var hasChanges: Bool = false
    
    private var flashcardRepository: FlashcardRepository
    
    private var cancellables = Set<AnyCancellable>() // // speichert alle Combine-Subscriptions, um Speicherlecks zu vermeiden
    
    private var originalQuestion: String = ""
    private var originalAnswer: String = ""
    
    init(flashcardRepository: FlashcardRepository = FlashcardRepositoryImplementation()) {
        self.flashcardRepository = flashcardRepository
        setupValidation() // activierung die Combine - Pipline
        print("SetupValidation called from init")
        
    }
    
    // MARK: - Validation Setup
    // MARK: - Validation Setup
    private func setupValidation() {
        Publishers.CombineLatest4($question, $answer, $currentFolder, $selectedFlashcard)
            .removeDuplicates { prev, curr in
                prev.0 == curr.0 && prev.1 == curr.1 && prev.2?.id == curr.2?.id && prev.3?.id == curr.3?.id
            }
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .sink { [weak self] question, answer, folder, selectedFlashcard in
                guard let self = self else { return }
                
                let trimmedQuestion = question.trimmingCharacters(in: .whitespacesAndNewlines)
                let trimmedAnswer = answer.trimmingCharacters(in: .whitespacesAndNewlines)
                
                // Проверяем дубликаты только если есть папка и вопрос не пустой
                if let folder = folder, !trimmedQuestion.isEmpty {
                    self.checkIfCardExistsInternal(question: trimmedQuestion, in: folder)
                } else {
                    self.errorMessage = ""
                }
                
                // Проверяем наличие изменений
                self.checkForChanges(question: trimmedQuestion, answer: trimmedAnswer)
                
                // Логика для infoMessage с проверкой режима редактирования
                if trimmedQuestion.isEmpty && trimmedAnswer.isEmpty {
                    self.infoMessage = ""
                } else if !trimmedQuestion.isEmpty && trimmedAnswer.isEmpty {
                    self.infoMessage = "Only question is filled."
                } else if trimmedQuestion.isEmpty && !trimmedAnswer.isEmpty {
                    self.infoMessage = "Only answer is filled."
                } else if self.errorMessage.isEmpty {
                    // Различаем режимы создания и редактирования
                    if selectedFlashcard != nil {
                        if self.hasChanges {
                            self.infoMessage = "Ready to update!"
                        } else {
                            self.infoMessage = "No changes made."
                        }
                    } else {
                        self.infoMessage = "Ready to create!"
                    }
                }
                
                print("📤 Validation result - Error: '\(self.errorMessage)', Info: '\(self.infoMessage)', HasChanges: \(self.hasChanges)")
            }
            .store(in: &cancellables)
    }
    
    // Проверяем наличие изменений по сравнению с исходными значениями
    private func checkForChanges(question: String, answer: String) {
        self.hasChanges = question != originalQuestion || answer != originalAnswer
    }
    
    
    // Внутренняя функция для проверки дубликатов
    private func checkIfCardExistsInternal(question: String, in folder: Folder) {
        let exists = folder.flashcards.contains { flashcard in
            // Исключаем текущую редактируемую карточку при проверке
            if let selectedFlashcard = self.selectedFlashcard,
               flashcard.id == selectedFlashcard.id {
                return false
            }
            return flashcard.question.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() == question.lowercased()
        }
        
        if exists {
            self.errorMessage = "This card already exists..."
        } else {
            self.errorMessage = ""
        }
    }
    
    
    var isFormValid: Bool {             // prüft, ob das Formular gültig ist
        let trimmedQuestion = question.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedAnswer = answer.trimmingCharacters(in: .whitespacesAndNewlines)
        
        return !trimmedQuestion.isEmpty && !trimmedAnswer.isEmpty && errorMessage.isEmpty
    }
    
    func createNewFlashcard (in folder: Folder, context: ModelContext) {
        
        
        let timmedQuestion = question.trimmingCharacters(in: .whitespacesAndNewlines)
        
        checkIfCardExistsInternal(question: timmedQuestion, in: folder)
        
        guard errorMessage.isEmpty else {
            return
        }
        
        do {
            let newFlashcard = try flashcardRepository.createFlashcard(
                question: question,
                answer: answer,
                in: folder,
                context: context
            )
            question = ""
            answer = ""
            selectedFlashcard = newFlashcard
            errorMessage = ""
            infoMessage = ""
            currentFolder = nil
            print("New Flashcard created successfully!")
        } catch {
            print("Error creating new flashcard: \(error)")
        }
    }
    
    //-----------
    func updateFlashcard(flashcard: Flashcard, context: ModelContext) {
        // Проверяем дубликаты перед обновлением
        if let folder = flashcard.folder {
            let trimmedQuestion = question.trimmingCharacters(in: .whitespacesAndNewlines)
            checkIfCardExistsInternal(question: trimmedQuestion, in: folder)
        }
        
        guard errorMessage.isEmpty else {
            print("Cannot update flashcard: \(errorMessage)")
            return
        }
        do {
            try flashcardRepository.updateFlashcard(
                flashcard: flashcard,
                question: question,
                answer: answer,
                context: context
            )
            // Обновляем исходные значения после успешного сохранения
            originalQuestion = question.trimmingCharacters(in: .whitespacesAndNewlines)
            originalAnswer = answer.trimmingCharacters(in: .whitespacesAndNewlines)
            hasChanges = false
            print("Flashcard updated successfully!")
        } catch {
            print("Error updating flashcard: \(error)")
        }
    }
    
    func loadFlashcardForEditing(flashcard: Flashcard) {
        self.question = flashcard.question
        self.answer = flashcard.answer
        self.isFavorite = flashcard.isFavorite
        self.selectedFlashcard = flashcard
        
        // Сохраняем исходные значения
        self.originalQuestion = flashcard.question.trimmingCharacters(in: .whitespacesAndNewlines)
        self.originalAnswer = flashcard.answer.trimmingCharacters(in: .whitespacesAndNewlines)
        self.hasChanges = false
        
        if let folder = flashcard.folder {
            self.currentFolder = folder
        }
        
        self.errorMessage = ""
        self.infoMessage = ""
    }
    
    func clearEditingData() {
        self.question = ""
        self.answer = ""
        self.isFavorite = false
        self.selectedFlashcard = nil
        self.currentFolder = nil
        self.errorMessage = ""
        self.infoMessage = ""
    }
    
    
    //-------
    
    func deleteFlashcard(flashcard: Flashcard, context: ModelContext) {
        do {
            try flashcardRepository.deleteFlashcard(
                flashcard: flashcard,
                context: context
            )
            print("Flashcard deleted successfully!")
            selectedFlashcard = nil
        } catch {
            print("Error deleting flashcard: \(error)")
        }
    }
}
