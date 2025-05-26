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
    
    @Published var isSheetCreateNewFlashcardOpen: Bool = false
    
    @Published var isFavorite: Bool = false
    
    @Published var selectedFlashcard: Flashcard?
    
    private var flashcardRepository: FlashcardRepository
    
    private var cancellables = Set<AnyCancellable>() // // speichert alle Combine-Subscriptions, um Speicherlecks zu vermeiden
    
    init(flashcardRepository: FlashcardRepository = FlashcardRepositoryImplementation()) {
        self.flashcardRepository = flashcardRepository
    }
    
    private func setupValidation() {    // richtet die Validierung für Eingabefelder ein
        $question                       // question - publisher reagieret auf enderung
            .removeDuplicates()         // entfernt doppelte Werte
            .sink { [weak self] _ in    // empfängt Werte und führt Aktion aus
                self?.errorMessage = "" // setzt Fehlermeldung zurück
            }
            .store(in: &cancellables)   // speichert die Subscription
    }
    
    var isFormValid: Bool {             // prüft, ob das Formular gültig ist
        let trimmedQuestion = question.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedAnswer = answer.trimmingCharacters(in: .whitespacesAndNewlines)
        
        return !trimmedQuestion.isEmpty && !trimmedAnswer.isEmpty && errorMessage.isEmpty
    }
    
    //func framework Combine, uberprüft ob flashcard schon gibt
    func checkIfCardExists(in folder: Folder) {
        let trimmedQuestion = question.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedQuestion.isEmpty else {
            errorMessage = ""
            return
        }
        
        let exists = folder.flashcards.contains { flashcard in
            flashcard.question.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() == trimmedQuestion.lowercased()
        }
        
        if exists {
            errorMessage = "This card already exists..."
        } else {
            errorMessage = ""
        }
    }
    
    func createNewFlashcard (in folder: Folder, context: ModelContext) {
        
        let trimmedQuestion = question.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedAnswer = answer.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedQuestion.isEmpty, !trimmedAnswer.isEmpty else {
            errorMessage = "Please enter both a question and an answer."
            return
        }
        checkIfCardExists(in: folder)
        
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
            print("New Flashcard created successfully!")
        } catch {
            print("Error creating new flashcard: \(error)")
        }
    }
    
    func updateFlashcard(flashcard: Flashcard, context: ModelContext) {
        do {
            try flashcardRepository.updateFlashcard(
                flashcard: flashcard,
                question: question,
                answer: answer,
                context: context
            )
            selectedFlashcard = nil
            print("Flashcard updated successfully!")
        } catch {
            print("Error updating flashcard: \(error)")
        }
    }
    
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
