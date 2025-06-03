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
    let deck: Deck
    
    var body: some View {
        List {
            ForEach(deck.folders) { folder in
                NavigationLink(value: folder) {
                    Text(folder.name)
                }
                .swipeActions(edge: .trailing) {
                    Button{
                        folderViewModel.selectedFolder = folder
                        folderViewModel.showAlerDeleteFolder = true
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                    .tint(.red)
                    
                    Button {
                        folderViewModel.selectedFolder = folder
                        folderViewModel.folderName = folder.name
                        folderViewModel.showAlertUpdateFolder = true
                    } label: {
                        Label ("Edit", systemImage: "pencil")
                    }
                    .tint(.yellow)
                }
            }
        }
        .listStyle(.plain)
//        .navigationTitle(deck.title)
        .navigationDestination(for: Folder.self) { folder in
            FlashcardView(selectedFolder: folder)
        }
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
                }
                folderViewModel.showAlertCreateNewFolder = false
            }
            
            Button ("Cancel", role: .cancel) {
                folderViewModel.folderName = ""
                folderViewModel.showAlertCreateNewFolder = false
            }
        }
        .alert("Delete Folder", isPresented: $folderViewModel.showAlerDeleteFolder) {
            Button("Delete", role: .destructive) {
                if let selectedFolder = folderViewModel.selectedFolder {
                    folderViewModel.deleteFolder(context: modelContext, folder: selectedFolder)
                    folderViewModel.selectedFolder = nil
                }
            }
            Button("Cancel", role: .cancel) {
                folderViewModel.showAlerDeleteFolder = false
                folderViewModel.selectedFolder = nil
            }
        }
        .alert("Update Folder Name", isPresented: $folderViewModel.showAlertUpdateFolder) {
            TextField("Folder Name", text: $folderViewModel.folderName)
            Button("Save") {
                if let selectedFolder = folderViewModel.selectedFolder {
                    folderViewModel.updateFolderName(folder: selectedFolder, newName: folderViewModel.folderName, context: modelContext)
                    folderViewModel.selectedFolder = nil
                }
            }
            Button("Cancel", role: .cancel) {
                folderViewModel.showAlertUpdateFolder = false
                folderViewModel.selectedFolder = nil
                folderViewModel.folderName = ""
            }
        }
    }
}

