//
//  FlashcardRepository.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 22.05.25.
//
import SwiftData

protocol FlashcardRepository {
    func createFlashcard(flashcardName: String, in folder: Folder, context: ModelContext) throws -> Flashcard
    
    func deleteFlashcard(flashcard: Flashcard, context: ModelContext) throws
    
    func updateFlashcard(flashcard: Flashcard, newName: String, context: ModelContext)
}
