//
//  SwiftDataDeckRepository.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 19.05.25.
//
import SwiftData
import SwiftUI

class SwiftDataDeckRepository: DeckRepository {
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
    }
    
    func deleteDeck(_ deck: Deck, context: ModelContext) throws {
        
    }
    
    func updateDeckName(_ deck: Deck, newName: String, context: ModelContext) throws {

    }
    
    
}
