//
//  FlashcardView.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 23.05.25.
//

import SwiftUI
import SwiftData
import AlertToast

struct FlashcardView: View {
    @EnvironmentObject private var flashcardViewModel: FlashcardViewModel
    @EnvironmentObject private var folderViewModel: FolderViewModel
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Flashcard.creationDate, order: .reverse) private var flashcards: [Flashcard]
    
    var selectedFolder: Folder?
    //    var selectedFlashcard: Flashcard?
    
    var body: some View {
        List {
            ForEach(flashcards.filter { $0.folder == selectedFolder }, id: \.self) { flashcard in
                NavigationLink(value: flashcard) {
                    Text(flashcard.question)
                }
                .swipeActions(edge: .trailing) {
                    Button {
                        flashcardViewModel.selectedFlashcard = flashcard
                        flashcardViewModel.alertDeleteFlashcardIsPresent = true
                    } label : {
                        Label("Delete", systemImage: "trash")
                    }
                    .tint(.red)
                }
            }
            
        }
        .listStyle(.plain)
        .navigationTitle(selectedFolder?.name ?? "Flashcards")
        .navigationDestination(for: Flashcard.self) { flashcard in
            EditFlashcardView(selectedFlashcard: flashcard)
                .environmentObject(flashcardViewModel)
        }
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
        .alert("Delete Flashcard form: \(selectedFolder?.name ?? "Unknown") ", isPresented: $flashcardViewModel.alertDeleteFlashcardIsPresent) {
            Button("Delete", role: .destructive) {
                if let selectedFlashcard = flashcardViewModel.selectedFlashcard {
                    flashcardViewModel.deleteFlashcard(flashcard: selectedFlashcard, context: modelContext)
                }
            }
            Button("Cancel", role: .cancel) {
                flashcardViewModel.alertDeleteFlashcardIsPresent = false
                flashcardViewModel.selectedFlashcard = nil
            }
        }
        .toast(
            isPresenting: $flashcardViewModel.toastMessageIfFlashcardCreated,
            duration: 1,
            tapToDismiss: true) {
                AlertToast(
                    displayMode: .hud,
                    type: .regular,
                    title: "Flashcard Created!",
//                    style: .init(
//                        backgroundColor: .green.opacity(0.5),
//                        titleColor: .white
//                    )
                )
        }
    }
}
