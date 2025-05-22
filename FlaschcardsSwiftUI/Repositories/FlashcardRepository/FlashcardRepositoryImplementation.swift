//
//  FlashcardRepositoryImplementation.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 22.05.25.
//
import SwiftData
import Foundation

class FlashcardRepositoryImplementation: FlashcardRepository {
    
    func createFlashcard(flashcardName: String, in folder: Folder, context: ModelContext) throws -> Flashcard {
        
        if flashcardName.isEmpty {
            throw Errors.emptyTitle
        }
        
        var newFlashcard = Flashcard(
            id: UUID(),
            question: "",
            answer: "",
        )
        context.insert(newFlashcard)
//        folder.
        
        return newFlashcard
    }
    
    func deleteFlashcard(flashcard: Flashcard, context: ModelContext) throws {
        
    }
    
    func updateFlashcard(flashcard: Flashcard, newName: String, context: ModelContext) {
        
    }
    
    
}
