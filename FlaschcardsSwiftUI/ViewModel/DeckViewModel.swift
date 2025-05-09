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
    
    func createNewDeck(context: ModelContext) {
        guard !deckName.isEmpty else { return }
        
        let newDeck = Deck(id: UUID(), title: deckName, deckDescription: deckDescription, flashcards: [], createdAt: Date())
        
        context.insert(newDeck)
        
        do {
            try context.save()
            print("Deck: \(newDeck) saved successfully!")
            deckName = ""
            deckDescription = ""
            newDeckSheetIsPresented = false
        } catch {
            print("Failed to save context: \(error)")
        }
    }
    
    func deleteDeck(context: ModelContext, deck: Deck) {
        context.delete(deck)
        
        do {
            try context.save()
        } catch {
            print("Failed to save context: \(error)")
        }
    }
}
