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
    @Published var deckName: String = ""
    @Published var deckDescription: String = ""
    @Published var showAlertDialogUpdateDeckName: Bool = false
    @Published var selectedDeck: Deck?
    
    private let deckRepository: DeckRepository
    
    init(deckRepository: DeckRepository = SwiftDataDeckRepository()) {
        self.deckRepository = deckRepository
    }
    func createNewDeck(context: ModelContext) {
        do {
            let _ = try deckRepository.createDeck(title: deckName, description: deckDescription, context: context)
            print("Deck \(deckName) saved successfully!")
            deckName = ""
        } catch {
            print("Faield to save context: \(error)")
        }
    }
    
    func deleteDeck(context: ModelContext, deck: Deck) {
        do {
            try deckRepository.deleteDeck(deck, context: context)
            print("Deck \(deck.title) deleted successfully!")
        } catch {
            print("Error deleting deck: \(error)")
        }
    }
    
    func updateDeckName(context: ModelContext, deck: Deck, newName: String) {
        do {
            try deckRepository.updateDeckName(deck, newName: newName, context: context)
            print("Deck \(deck.title) updated successfully!")
        } catch {
            print("Failde to update deck name: \(error)")
        }
    }
    
//    func deleteDeck(context: ModelContext, deck: Deck) {
//        context.delete(deck)
//        
//        do {
//            try context.save()
//            print("\(deck.title) - deleted successfully!")
//        } catch {
//            print("Failed to save context: \(error)")
//        }
//    }
//    
//    func updateDeckName(context: ModelContext, deck: Deck, newName: String) {
//        guard !deckName.isEmpty else { return }
//        
//        deck.title = newName
//        
//        do {
//            try context.save()
//            print("\(deck.title) - updated successfully!")
//        } catch {
//            print("Failed to save context: \(error)")
//        }
//    }
}
