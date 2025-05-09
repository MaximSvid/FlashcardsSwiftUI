//
//  FlaschcardsSwiftUIApp.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 30.04.25.
//

import SwiftUI
import SwiftData

@main
struct FlaschcardsSwiftUIApp: App {
    @StateObject private var deckViewModel = DeckViewModel()
    var body: some Scene {
        WindowGroup {
            TabNavigation()
        }
        .environmentObject(deckViewModel)
        .modelContainer(for: [Deck.self, Flashcard.self])
    }
}
