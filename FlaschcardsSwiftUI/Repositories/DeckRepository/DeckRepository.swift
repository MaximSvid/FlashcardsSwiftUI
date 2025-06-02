//
//  DeckRepository.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 19.05.25.
//
import SwiftData
protocol DeckRepository {
    func createDeck(title: String, description: String?, context: ModelContext) throws -> Deck
    func deleteDeck(_ deck: Deck, context: ModelContext) throws
    func updateDeckName(_ deck: Deck, newName: String, context: ModelContext) throws
}
