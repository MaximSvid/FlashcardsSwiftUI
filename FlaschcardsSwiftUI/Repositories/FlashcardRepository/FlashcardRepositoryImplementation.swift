//
//  FlashcardRepositoryImplementation.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 22.05.25.
//
import SwiftData
import Foundation

class FlashcardRepositoryImplementation: FlashcardRepository {
    
    func createFlashcard(question: String, answer: String, in folder: Folder, context: ModelContext) throws -> Flashcard {
        if question.isEmpty || answer.isEmpty {
            throw Errors.emptyTitle
        }
        
        let newFlashcard = Flashcard(
            id: UUID(),
            question: question,
            answer: answer,
            creationDate: Date(),
            folder: folder
        )
        context.insert(newFlashcard)
        folder.flashcards.append(newFlashcard) // aa to folder's lfashcards array
        try context.save() // save the context to presist the re;ationship
        
        return newFlashcard
    }
    
        
    func deleteFlashcard(flashcard: Flashcard, context: ModelContext) throws {
        context.delete(flashcard)
        try context.save()
    }
    
    func updateFlashcard(flashcard: Flashcard, question: String, answer: String, context: ModelContext) throws {
        if question.isEmpty || answer.isEmpty {
            throw Errors.emptyTitle
        }
        
        flashcard.question = question
        flashcard.answer = answer
        try context.save()
    }
    
    func saveCardDifficulty(flashcard: Flashcard, difficulty: CardDifficulty, context: ModelContext) throws {
        flashcard.difficulty = difficulty
        try context.save()
    }
    
//    func updateCardDifficulty(flashcard: Flashcard, difficulty: CardDifficulty, context: ModelContext) {
//        
//        
//        context.save()
//    }
}
