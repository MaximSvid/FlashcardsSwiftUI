//
//  EmptyFoldersPlaceholder.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 10.06.25.
//

import SwiftUI

struct EmptyFoldersPlaceholder: View {
    @EnvironmentObject private var folderViewModel: FolderViewModel
    @State private var showCreateFolderSheet: Bool = false
    
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
            
//            Button(action: {
//                showCreateFolderSheet = true
//            }) {
//                Text("Create a folder")
//                    .font(.headline)
//                    .frame(maxHeight: 50)
//                    .foregroundStyle(.white)
//                    .background(Color.blue.opacity(0.9))
//                    .clipShape(RoundedRectangle(cornerRadius: 12))
//            }
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


