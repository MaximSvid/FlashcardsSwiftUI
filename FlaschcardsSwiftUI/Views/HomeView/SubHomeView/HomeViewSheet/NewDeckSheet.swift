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
                        ForEach(Language.allCases) { language in
                            if decks.contains(where: { $0.targenLanguage == language}) {
                                Button(action: {
                                    deckViewModel.selectedLanguage = language
                                    deckViewModel.newDeckSheetIsPresented = false
                                }) {
                                    Text(language.rawValue)
                                }
                                .swipeActions(edge: .trailing) {
                                    Button(role: .destructive) {
                                        if let deckToDelete = decks.first(where: {$0.targenLanguage == language}) {
                                            deckViewModel.deleteDeck(context: modelContext, deck: deckToDelete)
                                        }                                    } label: {
                                            Label("Delete", systemImage: "trash")
                                        }
                                }
                            }
                            
                        }
                    }
                    .listStyle(.plain)
                } else {
                    VStack {
                        Text("No decks available")
                            .font(.callout)
                            .foregroundStyle(.gray)
                        Spacer()
                        Divider()
                        NavigationLink {
                            CreateDeckSheet()
                                .environmentObject(deckViewModel)
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
