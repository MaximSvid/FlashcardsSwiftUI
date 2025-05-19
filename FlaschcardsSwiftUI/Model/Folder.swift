//
//  Folder.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 19.05.25.
//

import SwiftUI
import SwiftData

@Model
class Folder {
    var id: UUID
    var name: String
    var createdAt: Date
    @Relationship(deleteRule: .cascade) var flashcards: [Flashcard] = []
    
    init(
        id: UUID = .init(),
         name: String = "",
         createdAt: Date = Date(),
         flashcards: [Flashcard] = []
    ) {
        self.id = id
        self.name = name
        self.createdAt = createdAt
    }
    
}
