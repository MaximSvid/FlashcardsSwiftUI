//
//  DeckViewModel.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 09.05.25.
//
import SwiftUI
import SwiftData

class DeckViewModel: ObservableObject {
    @Published var newDeckSheetIsPresented: Bool = false
    @Published var selectedLanguage: Language = .english
    
    @Published var showAlertDialogUpdateDeckNameHomeView: Bool = false
    @Published var showAlertDialogUpdateDeckNameDeckView: Bool = false
    
    @Published var showAlertDialogCreateNewDeck: Bool = false
    @Published var showAlertDialogDeleteDeck: Bool = false
    
    @Published var selectedDeck: Deck?
    
    private let deckRepository: DeckRepository
    
    init(deckRepository: DeckRepository = DeckRepositoryImplementation()) {
        self.deckRepository = deckRepository
    }
    func createNewDeck(context: ModelContext) {
        do {
            let _ = try deckRepository.createDeck(targetLanguage: selectedLanguage, context: context)
            print("Deck saved successfully!")
            selectedLanguage = .english
        } catch {
            print("Faield to save context: \(error)")
        }
    }
    
    func deleteDeck(context: ModelContext, deck: Deck) {
        do {
            try deckRepository.deleteDeck(deck, context: context)
            print("Deck deleted successfully!")
        } catch {
            print("Error deleting deck: \(error)")
        }
    }
}
