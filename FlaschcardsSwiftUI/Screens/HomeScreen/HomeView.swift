//
//  HomeView.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 30.04.25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var deckViewModel = DeckViewModel()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                Divider()
                FlaschcardsInfo()
                Spacer()
                MainButton(action: {}, title: "Start")
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
                        Text("New Deck")
                            .foregroundStyle(.gray)
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
            .environmentObject(deckViewModel)
            .sheet(isPresented: $deckViewModel.newDeckSheetIsPresented) {
                NewDeckSheet()
                //                    .environmentObject(deckViewModel)
                    .presentationDetents([.fraction(0.7)])
                    .presentationDragIndicator(.visible)
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(DeckViewModel())
}
