//
//  MockDeckRepository.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 22.05.25.
//

import Foundation
import SwiftData

class MockDeckRepository: DeckRepository {
        
    
    var shouldThrowError: Bool = false
    var createDeck: Deck?
    var deleteDeck: Deck?
//    var updateDeck: Deck?
//    var updatedDeckName: String?
    
    func createDeck(targetLanguage: Language, context: ModelContext) throws -> Deck {
        if shouldThrowError{
            throw Errors.emptyTitle
        }
        let deck = Deck(
            id: UUID(),
//            title: title,
//            deckDescription: description,
            folders: [],
            createdAt: Date(),
            targenLanguage: targetLanguage
        )
        createDeck = deck
        return deck
    }
    
    func deleteDeck(_ deck: Deck, context: ModelContext) throws {
        if shouldThrowError {
            throw Errors.errorDeleteDeck
        }
        deleteDeck = deck
    }
    
    func updateDeckName(_ deck: Deck, newName: String, context: ModelContext) throws {
        
        if shouldThrowError {
            throw Errors.errorUpdateDeck
        }
//        updateDeck = deck
//        updatedDeckName = newName
//        deck.title = newName
    }
    
    
}
