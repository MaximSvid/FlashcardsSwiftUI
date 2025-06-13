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
    @Published var errorIcon:String = ""
    @Published var infoIcon:String = ""
    
    @Published var isSheetCreateNewFlashcardOpen: Bool = false
    @Published var alertDeleteFlashcardIsPresent: Bool = false
    
    @Published var isFavorite: Bool = false
    
    @Published var selectedFlashcard: Flashcard?
    @Published var currentFolder: Folder?
    
    // Добавляем свойство для отслеживания изменений
    @Published var hasChanges: Bool = false
    
    @Published var toast: Toast? = nil
    
    private var flashcardRepository: FlashcardRepository
    
    private var cancellables = Set<AnyCancellable>() // // speichert alle Combine-Subscriptions, um Speicherlecks zu vermeiden
    
    private var originalQuestion: String = ""
    private var originalAnswer: String = ""
    
    init(flashcardRepository: FlashcardRepository = FlashcardRepositoryImplementation()) {
        self.flashcardRepository = flashcardRepository
        setupValidation() // activierung die Combine - Pipline
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
                
                // Сбрасываем сообщения и иконки
                self.errorMessage = ""
                self.errorIcon = ""
                self.infoMessage = ""
                self.infoIcon = ""
                
                // Проверяем дубликаты
                if let folder = folder, !trimmedQuestion.isEmpty {
                    self.checkIfCardExistsInternal(question: trimmedQuestion, in: folder)
                }
                // Проверяем наличие изменений
                self.checkForChanges(question: trimmedQuestion, answer: trimmedAnswer)
                
                // Логика для infoMessage и infoIcon
                if !self.errorMessage.isEmpty {
                    self.infoMessage = "" // Очищаем infoMessage при наличии ошибки
                    self.infoIcon = ""
                } else if trimmedQuestion.isEmpty && trimmedAnswer.isEmpty {
                    self.infoMessage = ""
                    self.infoIcon = ""
                } else if !trimmedQuestion.isEmpty && trimmedAnswer.isEmpty {
                    self.infoMessage = "Please enter an answer."
                    self.infoIcon = "info.circle.fill"
                } else if trimmedQuestion.isEmpty && !trimmedAnswer.isEmpty {
                    self.infoMessage = "Please enter a question."
                    self.infoIcon = "info.circle.fill"
                } else {
                    if selectedFlashcard != nil {
                        self.infoMessage = self.hasChanges ? "Ready to update!" : "No changes made."
                        self.infoIcon = self.hasChanges ? "checkmark.circle.fill" : "info.circle.fill"
                    } else {
                        self.infoMessage = "Ready to create!"
                        self.infoIcon = "checkmark.circle.fill"
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
            self.errorIcon = "exclamationmark.triangle.fill"
        } else {
            self.errorMessage = ""
            self.errorIcon = ""
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
            
            // Используем глобальный ToastManager
            ToastManager.shared.show(
                Toast(style: .success, message: "Flashcard created successfully!")
            )
            print("New Flashcard created successfully!")
        } catch {
            ToastManager.shared.show(
                Toast(style: .error, message: "Failed to create flashcard")
            )
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
            ToastManager.shared.show(
                Toast(style: .info, message: "Flashcard deleted successfully!")
            )
        } catch {
            ToastManager.shared.show(
                Toast(style: .error, message: "Failed to delete flashcard")
            )
            print("Error deleting flashcard: \(error)")
        }
    }
    
    func saveCardDifficulty(flashcard: Flashcard, difficulty: CardDifficulty, context: ModelContext)  {
        do {
            try flashcardRepository.saveCardDifficulty(flashcard: flashcard, difficulty: difficulty, context: context)
        } catch {
            ToastManager.shared.show(
                Toast(style: .error, message: "Failed to save card difficulty")
            )
            print("Saving card difficulty failed: \(error)")
        }
    }
    
    var difficultyStats: (easy: Int, normal: Int, hard: Int) {
        guard let flashcards = currentFolder?.flashcards else {
            return (easy: 0, normal: 0, hard: 0)
        }
        return (
            easy: flashcards.filter { $0.difficulty == .easy}.count,
            normal: flashcards.filter { $0.difficulty == .normal}.count,
            hard: flashcards.filter { $0.difficulty == .hard}.count,
        )
    }
    
    //MARK: nich richtig functionieret
     var totalFlashcards: Int {
        currentFolder?.flashcards.count ?? 0
    }
}

extension FlashcardViewModel {
    
    // Метод для получения статистики сложности для конкретной папки
    func getDifficultyStats(for folder: Folder) -> (easy: Int, normal: Int, hard: Int) {
        let flashcards = folder.flashcards
        return (
            easy: flashcards.filter { $0.difficulty == .easy }.count,
            normal: flashcards.filter { $0.difficulty == .normal }.count,
            hard: flashcards.filter { $0.difficulty == .hard }.count
        )
    }
    
    // Метод для получения общего количества карточек в папке
    func getTotalFlashcards(for folder: Folder) -> Int {
        return folder.flashcards.count
    }
}
