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
                
                if !decks.isEmpty {
                    List {
                        ForEach(decks) { deck in
                            Button(action: {
                                deckViewModel.selectedLanguage = deck.targetLanguage ?? .english
                                deckViewModel.selectedSourceLanguage = deck.sourceLanguage ?? .russian
                                deckViewModel.newDeckSheetIsPresented = false
                            }) {
                                HStack {
                                    Text(deck.sourceLanguage?.imageName ?? "")
                                    Text(deck.sourceLanguage?.displayName ?? "")
                                    Text("-")
                                    Text(deck.targetLanguage?.imageName ?? "")
                                    Text(deck.targetLanguage?.displayName ?? "")
                                }
                            }
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    deckViewModel.deleteDeck(context: modelContext, deck: deck)
                                } label: {
                                    Label ("Delete", systemImage: "trash")
                                }
                            }
                        }
                    }
                    .listStyle(.plain)
                } else {
                    VStack {
                        Image(systemName: "plus.rectangle.on.folder")
                            .font(.title)
                        Text("No decks available")
                            .font(.callout)
                            .foregroundStyle(.gray)
                    }
//                    Spacer()

                }
                
                Divider()
                NavigationLink {
                    CreateDeckSheet()
                } label: {
                    Text("New Deck +")
                        .font(.headline)
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .foregroundStyle(.white)
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding([.trailing, .leading, .bottom])
                }
            }
        }
    }
}
