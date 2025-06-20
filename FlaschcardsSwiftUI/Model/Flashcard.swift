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
    var comment: String?
    @Relationship(inverse: \Folder.flashcards) var folder: Folder? // inverse relationship to Folder
    
    // Study Progress Properties
    var difficulty: CardDifficulty? // speisherung nach schwierigkeit
    
    var lastReviewed: Date? // für wiederholungLogic
    var nextReviewDate: Date? // für wiederholungLogic
    
    var reviewCount: Int = 0 // für statistic

    
    init(id: UUID = UUID(), question: String, answer: String, isFavorite: Bool = false, creationDate: Date = Date(), folder: Folder? = nil) {
        self.id = id
        self.question = question
        self.answer = answer
        self.isFavorite = isFavorite
        self.creationDate = creationDate
        self.comment = comment
        self.folder = folder
    }
}
