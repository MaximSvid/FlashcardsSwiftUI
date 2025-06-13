//
//  TabNavigation.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 07.05.25.
//

import SwiftUI

struct TabNavigation: View {
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
    }
}
 
