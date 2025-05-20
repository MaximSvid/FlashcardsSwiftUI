//
//  DeckList.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 20.05.25.
//

import SwiftUI
import SwiftData

struct DeckList: View {
    @EnvironmentObject private var deckViewModel: DeckViewModel
    @Environment(\.modelContext) private var modelContext
    @Query private var decks: [Deck]
    
    var body: some View {
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
                            deckViewModel.showAlertDialogUpdateDeckNameDeckView = true
                        } label: {
                            Label("Edit", systemImage: "pencil")
                        }
                        .tint(.yellow)
                    }
            }
        }
    }
}


