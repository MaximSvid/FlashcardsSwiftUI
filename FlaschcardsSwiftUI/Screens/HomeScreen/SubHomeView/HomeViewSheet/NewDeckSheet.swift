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
    @Query private var decks: [Deck]
    
    
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
                                    deckViewModel.updateDeckName(context: modelContext, deck: deck)
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
        }
    }
}

#Preview {
    NewDeckSheet()
}
