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
    @Relationship(deleteRule: .cascade) var folders: [Folder] = []
    var createdAt: Date
    
    init(
        id: UUID,
         title: String,
         deckDescription: String? = nil,
         folders: [Folder],
         createdAt: Date
    ) {
        self.id = id
        self.title = title
        self.deckDescription = deckDescription
        self.folders = folders
        self.createdAt = createdAt
    }
}
