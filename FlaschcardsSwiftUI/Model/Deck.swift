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
    @Relationship(deleteRule: .cascade) var folders: [Folder] = []
    var createdAt: Date
    var targetLanguage: Language? // sprache die man lernen mochtet
    var sourceLanguage: Language?
    init(
        id: UUID,
        folders: [Folder],
        createdAt: Date,
        targetLanguage: Language?,
        sourceLanguage: Language?
    ) {
        self.id = id
        
        self.folders = folders
        self.createdAt = createdAt
        self.targetLanguage = targetLanguage
        self.sourceLanguage = sourceLanguage
    }
}
