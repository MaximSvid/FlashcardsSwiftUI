//
//  SwiftDataDeckRepository.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 19.05.25.
//
import SwiftData
import SwiftUI

class DeckRepositoryImplementation: DeckRepository {
    func createDeck(targetLanguage: Language, sourceLanguage: Language, context: ModelContext) throws -> Deck {
        let newDeck = Deck(
            id: UUID(),
            folders: [],
            createdAt: Date(),
            targetLanguage: targetLanguage,
            sourceLanguage: sourceLanguage
        )
        context.insert(newDeck)
        try context.save()
        return newDeck

    }
    
    func deleteDeck(_ deck: Deck, context: ModelContext) throws {
        context.delete(deck)
        try context.save()
    }
}
