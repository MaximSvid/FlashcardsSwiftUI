//
//  StudySessionViewModel.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 09.06.25.
//
import SwiftUI

class StudySessionViewModel: ObservableObject {
    @Published var currentCardIndex: Int = 0
    @Published var showingAnswer: Bool = false
    @Published var studySessionActive: Bool = false
    
    var flashcards: [Flashcard] = []
    
    var currentFlashcard: Flashcard? {
        guard currentCardIndex < flashcards.count else {
            return nil
        }
        return flashcards[currentCardIndex]
    }
    
    var hasNextCard: Bool {
        currentCardIndex < flashcards.count - 1
    }
    var hasPreviousCard: Bool {
        currentCardIndex > 0
    }
    
    func startStudySession(with folder: Folder) {
        self.flashcards = folder.flashcards
        self.currentCardIndex = 0
        self.showingAnswer = false
        self.studySessionActive = true
    }
    
    func showAnswer() {
        self.showingAnswer = true
    }
    
    func nextCard() {
        guard hasNextCard else {
            return
        }
        self.currentCardIndex += 1
        self.showingAnswer = false
    }
    
    func previousCard() {
        guard hasPreviousCard else {
            return
        }
        self.currentCardIndex -= 1
        self.showingAnswer = false
    }
    
    func endStudySession() {
        self.studySessionActive = false
        currentCardIndex = 0
        showingAnswer = false
        flashcards = []
    }
}
