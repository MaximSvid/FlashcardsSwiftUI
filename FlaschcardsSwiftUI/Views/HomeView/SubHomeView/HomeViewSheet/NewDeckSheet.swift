//
//  NewDeckSheet.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 07.05.25.
//

import SwiftUI
import SwiftData

struct NewDeckSheet: View {
    @EnvironmentObject private var deckViewModel: DeckViewModel
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Deck.createdAt, order: .reverse) private var decks: [Deck]
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Choose a deck")
                    .font(.title3.bold())
                    .padding()
                    .padding(.top, 20)
                
                List {
                    ForEach(decks) { deck in
                        Text(deck.title)
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    deckViewModel.deleteDeck(context: modelContext, deck: deck)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                                
                                Button {
                                    deckViewModel.selectedDeck = deck
                                    deckViewModel.deckName = deck.title
                                    deckViewModel.showAlertDialogUpdateDeckNameHomeView = true
                                } label: {
                                    Label("Edit", systemImage: "pencil")
                                }
                                .tint(.yellow)
                            }
                    }
                    
                }
                .listStyle(.plain)
                
                Divider()
                NavigationLink {
                    CreateDeckSheet()
                } label: {
                    Text("New Deck +")
                        .font(.headline)
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .foregroundStyle(.white)
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .padding([.trailing, .leading, .bottom])
                }
            }
            .alert("Edit Deck Name", isPresented: $deckViewModel.showAlertDialogUpdateDeckNameHomeView) {
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

#Preview {
    NewDeckSheet()
}
