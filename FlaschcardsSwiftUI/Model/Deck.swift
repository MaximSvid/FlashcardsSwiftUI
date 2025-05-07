//
//  Deck.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 07.05.25.
//

class Deck {
    let id: UUID
    var title: String
    var description: String?
    var flashcards: [Flashcard]
    var createdAt: Date
    
    init(id: UUID, title: String, description: String? = nil, flashcards: [Flashcard], createdAt: Date) {
        self.id = id
        self.title = title
        self.description = description
        self.flashcards = flashcards
        self.createdAt = createdAt
    }
}
