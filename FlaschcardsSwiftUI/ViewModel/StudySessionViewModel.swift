//
//  StudySessionViewModel.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 09.06.25.
//
import SwiftUI

class StudySessionViewModel: ObservableObject {
    @Published var currentFolder: Folder?
    @Published var currentCardIndex: Int = 0
    @Published var showingAnswer: Bool = false
    @Published var studySessionActive: Bool = false
    @Published var selectedLanguage: Language = .english
    @Published var isSoundEnabled: Bool = true // zustand von voice
    @Published var isSessionFinished: Bool = false //
    
    private let speechService: SpeechServiceProtocol
    @EnvironmentObject var folderViewModel: FolderViewModel // Вернули передачу через конструктор
    
    var flashcards: [Flashcard] = []
    
    init(speechService: SpeechServiceProtocol = SpeechServiceImplementation()) {
        self.speechService = speechService
//        self.folderViewModel = folderViewModel
    }
    
    //MARK: StudySession Start ----------------
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
        self.currentFolder = folder
        self.flashcards = folder.flashcards
        self.currentCardIndex = 0
        self.showingAnswer = false
        self.isSessionFinished = false
        self.studySessionActive = !folder.flashcards.isEmpty // nur when flashcards gibt
        if let deck = folder.deck {
            self.selectedLanguage = deck.targetLanguage ?? .english
        }
    }
    
    func startNextFolderStudySession() {
        guard let currentFolder = currentFolder else {
            print("No folder selected")
            return
        }
        
        if let nextFolder = folderViewModel.getNextFolder(after: currentFolder) {
            startStudySession(with: nextFolder)
        } else {
            ToastManager.shared.show(Toast(style: .info, message: "No more folders to study"))
        }
    }
    
    func showAnswer() {
        self.showingAnswer = true
    }
    
    func nextCard() {
        if hasNextCard {
            self.currentCardIndex += 1
            self.showingAnswer = false
        } else {
            completeStudySession()
        }
    }
    
    func previousCard() {
        guard hasPreviousCard else {
            return
        }
        self.currentCardIndex -= 1
        self.showingAnswer = false
    }
    
    func completeStudySession() {
        self.isSessionFinished = true
        self.showingAnswer = false
        print("Study session completed! All cards have been studied.")
    }
    
    func endStudySession() {
        self.studySessionActive = false
        currentCardIndex = 0
        showingAnswer = false
        flashcards = []
    }
    
    // Метод для перезапуска сессии (например, для повторного изучения)
    func restartSession() {
        guard let folder = currentFolder else { return }
        startStudySession(with: folder)
    }
    
    func checkIfSessionCompleted() {
        if flashcards.isEmpty {
            isSessionFinished = true
        }
    }
    
    // Метод для изучения карточек определенной сложности
    func startStudySessionWithDifficulty(_ difficulty: CardDifficulty, from folder: Folder? = nil) {
        
        let targetFolder = folder ?? currentFolder
        guard let selectedFolder = targetFolder else { return }
        let filteredCards = selectedFolder.flashcards.filter { $0.difficulty == difficulty }
        
        if !filteredCards.isEmpty {
            self.flashcards = filteredCards
            self.currentCardIndex = 0
            self.showingAnswer = false
            self.isSessionFinished = false
            self.studySessionActive = true
        } else {
            ToastManager.shared.show(Toast(style: .info, message: "Flashcards for this difficulty level are empty")) // nicht functionieret
        }
    }
    
    //MARK: StudySession End ----------------
    
    //MARK: Voice Start--------------------
    func toggleSound() {
        if isSoundEnabled {
            isSoundEnabled = false
            stopSpeaking()
        } else {
            isSoundEnabled = true
            speakQuestion()
        }
    }
    
    func speakQuestion() {
        if let question = currentFlashcard?.question {
            speechService.speak(text: question, language: selectedLanguage)
        }
    }
    
    func stopSpeaking() {
        speechService.stopSpeaking()
    }
    
    
    func speakQuestionIfEnabled() {
        // Метод для автоматического воспроизведения с проверкой настроек
        if isSoundEnabled {
            speakQuestion()
        }
    }
    var soundIconName: String {
        isSoundEnabled ? "speaker.wave.2" : "speaker.slash"
    }
    //MARK: Voice End-----------------
    
}
