//
//  FlashcardView.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 23.05.25.
//

import SwiftUI
import SwiftData

struct FlashcardView: View {
    @EnvironmentObject private var flashcardViewModel: FlashcardViewModel
    @EnvironmentObject private var folderViewModel: FolderViewModel
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Flashcard.creationDate, order: .reverse) private var flashcards: [Flashcard]
    
    var selectedFolder: Folder?
    
    var body: some View {
        List {
            ForEach(flashcards.filter { $0.folder == selectedFolder }) { flashcard in
                Text(flashcard.question)
            }
        }

        .listStyle(.plain)
        .navigationTitle(selectedFolder?.name ?? "Flashcards")
        .toolbar {
            ToolbarItem (placement: .topBarTrailing) {
                Button(action: {
                    flashcardViewModel.isSheetCreateNewFlashcardOpen = true
                }) {
                    Image(systemName: "square.and.pencil")
                        .font(.headline)
                }
            }
        }
        .sheet(isPresented: $flashcardViewModel.isSheetCreateNewFlashcardOpen) {
            CreateFlashcardSheet(selectedFolder: selectedFolder)
                .environmentObject(flashcardViewModel)
                .environmentObject(folderViewModel)
                .presentationDragIndicator(.visible)
        }
    }
}
