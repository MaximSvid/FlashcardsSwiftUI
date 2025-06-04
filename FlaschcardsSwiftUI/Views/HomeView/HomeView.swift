//
//  HomeView.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 30.04.25.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @EnvironmentObject private var deckViewModel: DeckViewModel
    @Query(sort: \Deck.createdAt, order: .reverse) private var decks: [Deck]

    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                Divider()
                FlaschcardsInfo()
                Spacer()
                MainButton(action: {}, title: "Start")
                    .padding(.bottom, 30)
            }
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.blue.opacity(0.03))
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        //action
                    }) {
                        Image(systemName: "paintpalette")
                            .foregroundStyle(.gray)
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Button(action: {
                        deckViewModel.newDeckSheetIsPresented = true
                    }) {
                        HStack {
                            Text(deckViewModel.selectedDeck?.targetLanguage?.imageName ?? "")
                            Text(decks.contains { $0.targetLanguage == deckViewModel.selectedLanguage }
                                 ? deckViewModel.selectedLanguage.rawValue
                                 : "Create a deck")
                            Image(systemName: "arrowshape.down")
                                .font(.footnote)
                        }
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        //action
                    }) {
                        Image(systemName: "chart.bar")
                            .foregroundStyle(.gray)
                    }
                }
            }
            .toolbarBackground(Color.white, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .sheet(isPresented: $deckViewModel.newDeckSheetIsPresented) {
                NewDeckSheet()
                    .environmentObject(deckViewModel)
                    .presentationDragIndicator(.visible)
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(DeckViewModel())
}
