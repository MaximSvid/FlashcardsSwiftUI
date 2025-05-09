//
//  NewDeckSheet.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 07.05.25.
//

import SwiftUI

struct NewDeckSheet: View {
    //    @State private var showingModal = false  um ViewModel umwandeln
    @EnvironmentObject private var deckViewModel: DeckViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Text("Choose a deck")
                    .font(.headline)
                    .padding(.top)
                
                List {
                    ListNewDeck()
                    ListNewDeck()
                    ListNewDeck()
                    ListNewDeck()
                }
                .listStyle(.plain)
                
                Divider()
                NavigationLink {
                    CreateDeckSheet()
                } label: {
                    Text("New Deck +")
                        .font(.headline)
                        .buttonStyle(.borderedProminent)
                        .foregroundStyle(.green)
                }
            }
            .padding()
        }
        
    }
}

#Preview {
    NewDeckSheet()
}
