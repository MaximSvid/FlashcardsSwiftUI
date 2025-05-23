//
//  FlashcardViewModel.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 23.05.25.
//
import SwiftUI
import SwiftData

class FlashcardViewModel {
    
    @Published var question: String = ""
    @Published var answer: String = ""
    
    @Published var isFavorite: Bool = false
    
    @Published var selectedFlashcard: Flashcard?
    
    
    private var flashcardRepository: FlashcardRepository
    
    init(flashcardRepository: FlashcardRepository = FlashcardRepositoryImplementation()) {
        self.flashcardRepository = flashcardRepository
    }
    
    func createNewFlashcard (in folder: Folder, context: ModelContext) {
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
