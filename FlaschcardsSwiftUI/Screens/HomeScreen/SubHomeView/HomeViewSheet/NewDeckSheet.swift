//
//  NewDeckSheet.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 07.05.25.
//

import SwiftUI

struct NewDeckSheet: View {
    @State private var showingModal = false // um ViewModel umwandeln
    
    var body: some View {
        ZStack {
            Button(action: {
                showingModal = true
            }) {
                Text("New Deck")
                    .foregroundStyle(.gray)
            }
        }
        if showingModal {

            VStack {
                Text("Choose a deck")
                    .font(.headline)
                
                List {
                    ListNewDeck()
                }
                .listStyle(.plain)
                
                Divider()
                Button(action: {
                    showingModal = false
                }) {
                    Text("New Deck +")
                        .font(.headline)
                        .buttonStyle(.borderedProminent)
                        .foregroundStyle(.green)
                }
            }
            .padding()
            .frame(maxWidth: 250, maxHeight: 300)
            .overlay(
                RoundedRectangle(cornerRadius: 3)
                    .stroke(.gray, lineWidth: 1)
            )
        }
    }
}

#Preview {
    NewDeckSheet()
}
