//
//  HomeFolderList.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 10.06.25.
//

import SwiftUI
import SwiftData

struct HomeFolderList: View {
    @EnvironmentObject private var deckViewModel: DeckViewModel
    let decks: [Deck]

    var body: some View {
        VStack {
            InfoCard(deck: decks.first!)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 2)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(.systemGray5), lineWidth: 1)
        )
        .padding(.horizontal)
    }
}
