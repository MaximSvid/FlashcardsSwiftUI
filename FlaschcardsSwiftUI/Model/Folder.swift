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
    @Relationship(inverse: \Deck.folders) var deck: Deck?
    
    init(
        id: UUID = .init(),
         name: String = "",
         createdAt: Date = Date(),
        deck: Deck? = nil
    ) {
        self.id = id
        self.name = name
        self.createdAt = createdAt
        self.deck = deck
    }
    
}
