//
//  Deck.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 07.05.25.
//
import SwiftUI
import SwiftData

@Model
class Deck {
    var id: UUID
    var title: String
    var deckDescription: String?
    @Relationship(deleteRule: .cascade) var flashcards: [Flashcard] = []
    var createdAt: Date
    
    init(id: UUID, title: String, deckDescription: String? = nil, flashcards: [Flashcard], createdAt: Date) {
        self.id = id
        self.title = title
        self.deckDescription = deckDescription
        self.flashcards = flashcards
        self.createdAt = createdAt
    }
}
