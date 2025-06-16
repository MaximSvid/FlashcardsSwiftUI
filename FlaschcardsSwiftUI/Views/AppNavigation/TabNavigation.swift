//
//  TabNavigation.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 07.05.25.
//

import SwiftUI

struct TabNavigation: View {
    @EnvironmentObject private var deckViewModel: DeckViewModel
    @EnvironmentObject private var folderViewModel: FolderViewModel
    @EnvironmentObject private var flashcardViewModel: FlashcardViewModel
    @EnvironmentObject private var studySessionViewModel: StudySessionViewModel
    
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house"){
                HomeView()
            }
            
            Tab("Deck", systemImage: "folder"){
                DeckView()
            }
            
            Tab("Settings", systemImage: "gear"){
                SettingsView()
            }
        }
        .environmentObject(deckViewModel)
        .environmentObject(folderViewModel)
        .environmentObject(flashcardViewModel)
        .environmentObject(studySessionViewModel)
    }
}

