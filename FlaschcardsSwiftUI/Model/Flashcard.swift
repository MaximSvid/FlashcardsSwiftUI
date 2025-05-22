//
//  Flashcard.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 07.05.25.
//
import SwiftUI
import SwiftData

@Model
class Flashcard {
    var id: UUID
    var question: String
    var answer: String
    var isFavorite: Bool
    var creationDate: Date
    var coment: String?
//    @Relationship(inverse: \Folder.)
    
    init(id: UUID = UUID(), question: String, answer: String, isFavorite: Bool = false, creationDate: Date = Date()) {
        self.id = id
        self.question = question
        self.answer = answer
        self.isFavorite = isFavorite
        self.creationDate = creationDate
    }
}
