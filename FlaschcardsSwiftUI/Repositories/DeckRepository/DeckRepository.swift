//
//  DeckRepository.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 19.05.25.
//
import SwiftData
protocol DeckRepository {
    func createDeck(targetLanguage: Language, sourceLanguage: Language, context: ModelContext) throws -> Deck
    func deleteDeck(_ deck: Deck, context: ModelContext) throws
}
