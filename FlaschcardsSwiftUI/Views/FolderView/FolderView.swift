//
//  FolderView.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 20.05.25.
//

import SwiftUI
import SwiftData

struct FolderView: View {
    @EnvironmentObject private var folderViewModel: FolderViewModel
    @Environment(\.modelContext) private var modelContext
    @Query private var decks: [Deck]
    //    @Query(sort: \Folder.createdAt, order: .reverse) private var folders: [Folder]
    let deck: Deck
    
    var body: some View {
        List {
            ForEach(deck.folders) { folder in
                Text(folder.name)
            }
        }
        .listStyle(.plain)
        .navigationTitle(deck.title)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    folderViewModel.selectedDeck = deck
                    folderViewModel.showAlertCreateNewFolder = true
                }) {
                    Image(systemName: "square.and.pencil")
                        .font(.headline)
                }
            }
        }
        .alert("Create New Folder", isPresented: $folderViewModel.showAlertCreateNewFolder) {
            TextField ("Folder Name", text: $folderViewModel.folderName)
            Button("Create") {
                if let selectedDeck = folderViewModel.selectedDeck {
                    folderViewModel.createNewFolder(in: selectedDeck, context: modelContext)
                    
                    folderViewModel.folderName = ""
                    
                }
                folderViewModel.showAlertCreateNewFolder = false
            }
            Button ("Cancel", role: .cancel) {
                folderViewModel.folderName = ""
                folderViewModel.showAlertCreateNewFolder = false
            }
        }
    }
}

