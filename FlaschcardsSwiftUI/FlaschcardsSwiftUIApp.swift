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
    @StateObject private var folderViewModel = FolderViewModel()
    @StateObject private var flashcardViewModel = FlashcardViewModel()
    
    var body: some Scene {
        WindowGroup {
            TabNavigation()
                .withRootToast()
        }
        .environmentObject(deckViewModel)
        .environmentObject(folderViewModel)
        .environmentObject(flashcardViewModel)
        .modelContainer(for: [Deck.self, Folder.self, Flashcard.self])
    }
}
