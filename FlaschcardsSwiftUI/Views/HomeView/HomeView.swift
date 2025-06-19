//
//  HomeView.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 30.04.25.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @EnvironmentObject private var deckViewModel: DeckViewModel
    @EnvironmentObject private var studySessionViewModel: StudySessionViewModel
    @EnvironmentObject private var folderViewModel: FolderViewModel
    @EnvironmentObject private var flashcardViewModel: FlashcardViewModel
    @Query(sort: \Deck.createdAt, order: .reverse) private var decks: [Deck]
        
    
    var body: some View {
        NavigationView {
            mainContent
                .navigationBarTitleDisplayMode(.inline)
                .background(Color.blue.opacity(0.03))
                .toolbar { toolbarContent() }
                .toolbarBackground(Color.white, for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .overlay { dropdownOverlay }
                .sheet(isPresented: $deckViewModel.newDeckSheetIsPresented) {
                    NewDeckSheet()
                        .environmentObject(deckViewModel)
                        .presentationDragIndicator(.visible)
                        .withRootToast()
                }
                .sheet(isPresented: $folderViewModel.showCreateFolder) { createFolderSheet }
                .onAppear {
                    deckViewModel.updateSelectedDeck(from: decks)
                }                .onChange(of: deckViewModel.selectedLanguage){ _, _ in
                    deckViewModel.updateSelectedDeck(from: decks)
                }
                .onChange(of: decks) { _, _ in
                    deckViewModel.updateSelectedDeck(from: decks)
                }
        }
    }
    
    // Main content view
    private var mainContent: some View {
        ScrollView {
            if let selectedDeck = deckViewModel.selectedDeck, deckViewModel.hasAvailableFolders() {
                HomeFolderList(deck: selectedDeck)
                    .environmentObject(deckViewModel)
                    .environmentObject(folderViewModel)
                    .environmentObject(flashcardViewModel)
                    .environmentObject(studySessionViewModel)
            } else {
                EmptyFoldersPlaceholder(deck: deckViewModel.selectedDeck)
            }
            Spacer()
                .disabled(!deckViewModel.hasAvailableFolders())
                .padding(.bottom, 30)
        }
    }
    
    // Dropdown overlay view
    private var dropdownOverlay: some View {
        Group {
            if folderViewModel.showingDropDown {
                Color.black.opacity(0.1)
                    .ignoresSafeArea(.all)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            folderViewModel.showingDropDown = false
                        }
                    }
                    .overlay(alignment: .topTrailing) {
                        DropdownMenuRight()
                    }
            }
        }
    }
    
    // Create folder sheet view
    private var createFolderSheet: some View {
            CreateFolderHomeView(
                deck: deckViewModel.getDeckForCreateFolder()
            )
            .presentationDragIndicator(.visible)
            .withRootToast()
        }

    @ToolbarContentBuilder
    private func toolbarContent() -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            EmptyView()
        }
        ToolbarItem(placement: .principal) {
            principalToolbarButton()
        }
        ToolbarItem(placement: .topBarTrailing) {
            trailingButton()
        }
    }
    
    private func trailingButton() -> some View {
        Button(action: { folderViewModel.showingDropDown.toggle() }) {
            Image(systemName: "ellipsis")
                .foregroundStyle(.gray)
                .overlay(
                    Circle()
                        .fill(.gray.opacity(0.15))
                        .frame(width: 30, height: 30)
                )
        }
    }
    
    private func principalToolbarButton() -> some View {
        let hasSelectedDeck = deckViewModel.selectedDeck != nil
        
        return Button(action: {
            deckViewModel.newDeckSheetIsPresented = true
        }) {
            HStack(spacing: 8) {
                if hasSelectedDeck {
                    OverlappingFlags(
                        native: deckViewModel.selectedSourceLanguage,
                        target: deckViewModel.selectedLanguage,
                        size: 20
                    )
                } else {
                    Text("🌐")
                        .font(.system(size: 20))
                }
                Text(hasSelectedDeck ? deckViewModel.selectedLanguage.rawValue : "Create a deck")
                    .foregroundStyle(.black.opacity(0.8))
                    .font(.system(size: 16, weight: .medium))
                Image(systemName: "chevron.down")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(.black.opacity(0.6))
            }
        }
    }
}




