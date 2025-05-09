//
//  ListNewDeck.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 07.05.25.
//

import SwiftUI
import _SwiftData_SwiftUI

struct ListNewDeck: View {
    @Query(sort: \Deck.createdAt, order: .reverse) private var decks: [Deck]
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var deckViewModel: DeckViewModel
    
    var body: some View {
        ForEach(decks) { deck in
            HStack {
                Text(deck.title)
                    .font(.headline)
                Spacer()
                
                Button(action: {
//                    deckViewModel.deleteDeck(context: modelContext, deck: deck)
                }) {
                    Image(systemName: "pencil")
                        .font(.callout)
                }
            }
        }
        .onAppear {
            print("Deck available: \(decks.count)")
        }
    }
}

