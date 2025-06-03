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
    @Query(sort: \Deck.createdAt, order: .reverse) private var decks: [Deck]
    
    var body: some View {
        NavigationStack {
            //            VStack {
//            List {
//                ForEach(decks) { deck in
//                    NavigationLink(value: deck) {
//                        Text(deck.title)
//                    }
//                    .swipeActions(edge: .trailing) {
//                        Button {
//                            deckViewModel.selectedDeck = deck
//                            deckViewModel.showAlertDialogDeleteDeck = true
//                        } label: {
//                            Label("Delete", systemImage: "trash")
//                        }
//                        .tint(.red)
//                        
//                        Button {
//                            deckViewModel.selectedDeck = deck
//                            deckViewModel.deckName = deck.title
//                            deckViewModel.showAlertDialogUpdateDeckNameDeckView = true
//                        } label: {
//                            Label("Edit", systemImage: "pencil")
//                        }
//                        .tint(.yellow)
//                    }
//                }
//            }
//            .listStyle(.plain)
//            .navigationTitle (!decks.isEmpty ? "My Decks" : "Create a New Deck")
//            .navigationDestination(for: Deck.self) { deck in
//                FolderView(deck: deck)
//            }
//            .toolbar {
//                
//                ToolbarItem(placement: .topBarTrailing) {
//                    Button(action: {
//                        deckViewModel.showAlertDialogCreateNewDeck = true
//                    }) {
//                        Image(systemName: "square.and.pencil")
//                            .font(.headline)
//                    }
//                }
//            }
//            .alert("Edit Deck Name", isPresented: $deckViewModel.showAlertDialogUpdateDeckNameDeckView) {
//                TextField("Deck Name", text: $deckViewModel.deckName)
//                Button("Save") {
//                    if let selectedDeck = deckViewModel.selectedDeck {
//                        deckViewModel.updateDeckName(context: modelContext, deck: selectedDeck, newName: deckViewModel.deckName)
//                    }
//                }
//                Button("Cancel", role: .cancel) {
//                    deckViewModel.whenCancelUpdateDeckName()
//                }
//            } message: {
//                Text("Enter a new name for the deck.")
//            }
            
//            .alert("Create a new Deck", isPresented: $deckViewModel.showAlertDialogCreateNewDeck) {
//                TextField("Deck Name", text: $deckViewModel.deckName)
//                Button("Save") {
//                    deckViewModel.createNewDeck(context: modelContext)
//                }
//                Button("Cancel", role: .cancel) {
//                    deckViewModel.whenCancelUpdateDeckName()
//                }
//            } message: {
//                Text ("Enter a new name for the deck.")
//            }
//            .alert("Delete Deck", isPresented: $deckViewModel.showAlertDialogDeleteDeck) {
//                Button("Delete", role: .destructive) {
//                    if let selectedDeck = deckViewModel.selectedDeck {
//                        deckViewModel.deleteDeck(context: modelContext, deck: selectedDeck)
//                        deckViewModel.selectedDeck = nil
//                    }
//                }
//                Button("Cancel", role: .cancel) {
//                    deckViewModel.showAlertDialogDeleteDeck = false
//                    deckViewModel.selectedDeck = nil
//                }
//            }
            
        }
    }
}
