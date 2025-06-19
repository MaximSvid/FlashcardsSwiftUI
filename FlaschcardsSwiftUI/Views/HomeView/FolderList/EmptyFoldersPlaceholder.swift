//
//  EmptyFoldersPlaceholder.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 10.06.25.
//

import SwiftUI

struct EmptyFoldersPlaceholder: View {
    let deck: Deck?
    @EnvironmentObject private var folderViewModel: FolderViewModel
    @State private var showCreateFolderSheet: Bool = false
//    @Binding var showCreateFolder: Bool
    @EnvironmentObject private var deckViewModel: DeckViewModel

    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "folder.badge.plus")
                .font(.system(size: 48))
                .foregroundStyle(.secondary)
            
            Text("No folders with flashcards")
                .font(.headline)
                .foregroundStyle(.primary)
            
            Text("Create folders and add flashcards to start studying")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
                //добавить проверку если deck == nil или если deck не выбран тогда кнопка - create a deck иначе create a folder
            
            if deck == nil {
                MainButton(action: {
                    deckViewModel.newDeckSheetIsPresented = true
                }, title: "Create a deck")
            } else {
                Button(action: {
                    folderViewModel.showCreateFolder = true
                }) {
                    Text("Crate a folder")
                        .padding()
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.white)
                        .background(Color.green.opacity(0.9))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                
            }
            
        }
        .frame(maxWidth: .infinity)
//        .frame(height: 50)
        .padding(.vertical, 40)
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal)
        .fullScreenCover(isPresented: $showCreateFolderSheet) {
            FlashcardView() //bug
                .environmentObject(folderViewModel)
        }
    }
}


