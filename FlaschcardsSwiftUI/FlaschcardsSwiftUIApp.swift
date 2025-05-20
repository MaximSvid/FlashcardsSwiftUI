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
    
    var body: some Scene {
        WindowGroup {
            TabNavigation()
        }
        .environmentObject(deckViewModel)
        .environmentObject(folderViewModel)
        .modelContainer(for: [Deck.self, Folder.self, Flashcard.self])
    }
}
