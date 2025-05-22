//
//  SwiftDataDeckRepository.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 19.05.25.
//
import SwiftData
import SwiftUI

class DeckRepositoryImplementation: DeckRepository {
    func createDeck(title: String, description: String?, context: ModelContext) throws -> Deck {
        guard !title.isEmpty else {
            throw Errors.emptyTitle
        }
        
        let newDeck = Deck (
            id: UUID(),
            title: title,
            deckDescription: description,
            folders: [],
            createdAt: Date()
        )
        context.insert(newDeck)
        try context.save()
        return newDeck
    }
    
    func deleteDeck(_ deck: Deck, context: ModelContext) throws {
        context.delete(deck)
        try context.save()
    }
    
    func updateDeckName(_ deck: Deck, newName: String, context: ModelContext) throws {
        guard !newName.isEmpty else {
            throw Errors.emptyTitle
        }
        deck.title = newName
        try context.save()
    }
}
