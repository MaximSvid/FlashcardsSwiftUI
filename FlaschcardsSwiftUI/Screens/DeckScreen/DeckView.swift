//
//  DeckView.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 20.05.25.
//

import SwiftUI
import _SwiftData_SwiftUI

struct DeckView: View {
    @EnvironmentObject private var deckViewModel: DeckViewModel
    @Environment(\.modelContext) private var modelContext
    @Query private var decks: [Deck]
    
    var body: some View {
        NavigationView {
            VStack {
                DeckList()
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("My Decks")
                        .font(.headline)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        
                    }) {
                        Image(systemName: "square.and.pencil")
                            .font(.headline)
                    }
                }
            }
            .alert("Edit Deck Name", isPresented: $deckViewModel.showAlertDialogUpdateDeckNameDeckView) {
                TextField("Deck Name", text: $deckViewModel.deckName)
                Button("Save") {
                    if let selectedDeck = deckViewModel.selectedDeck {
                        deckViewModel.updateDeckName(context: modelContext, deck: selectedDeck, newName: deckViewModel.deckName)
                    }
                }
                Button("Cancel", role: .cancel) {
                    deckViewModel.whenCancelUpdateDeckName()
                }
            } message: {
                Text("Enter a new name for the deck.")
            }
        }
    }
}
