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
    @State private var showingDropdown: Bool = false
    @State private var showCreateFolder: Bool = false
    
    
    // Computed property for selected deck
    private var selectedDeck: Deck? {
        decks.first { $0.targetLanguage == deckViewModel.selectedLanguage }
    }
    
    // Check if there are folders with flashcards
    private var hasAvailableFolders: Bool {
        !(selectedDeck?.folders.isEmpty ?? true) // Показываем все папки, даже пустые
    }
    
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
                .sheet(isPresented: $showCreateFolder) { createFolderSheet }
                .onAppear {
                    updateSelectedDeck()
                }                .onChange(of: deckViewModel.selectedLanguage){ _, _ in
                    updateSelectedDeck()
                }
                .onChange(of: decks) { _, _ in
                    // а здесь обновлять эти папки
                    updateSelectedDeck()
                }
        }
    }
    
    //передаем правильно deck
    private func updateSelectedDeck() {
        deckViewModel.selectedDeck = selectedDeck
    }
    
    // Main content view
    private var mainContent: some View {
        ScrollView {
            if let selectedDeck = selectedDeck, hasAvailableFolders {
                HomeFolderList(deck: selectedDeck)
                    .environmentObject(deckViewModel)
                    .environmentObject(folderViewModel)
                    .environmentObject(flashcardViewModel)
                    .environmentObject(studySessionViewModel)
            } else {
                EmptyFoldersPlaceholder(deck: selectedDeck, showCreateFolder: $showCreateFolder)
            }
            Spacer()
                .disabled(!hasAvailableFolders)
                .padding(.bottom, 30)
        }
    }
    
    // Dropdown overlay view
    private var dropdownOverlay: some View {
        Group {
            if showingDropdown {
                Color.black.opacity(0.1)
                    .ignoresSafeArea(.all)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            showingDropdown = false
                        }
                    }
                    .overlay(alignment: .topTrailing) {
                        DropdownMenuRight(
                            isPresented: $showingDropdown,
                            showCreateFolder: $showCreateFolder // Передаем binding
                        )
                    }
            }
        }
    }
    
    // Create folder sheet view
    private var createFolderSheet: some View {
        CreateFolderHomeView(
            deck: deckViewModel.selectedDeck ?? Deck(
                id: UUID(),
                folders: [],
                createdAt: Date(),
                targetLanguage: .english,
                sourceLanguage: .english
            ), showCreateFolder: $showCreateFolder
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
        Button(action: { showingDropdown.toggle() }) {
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
        let hasSelectedDeck = selectedDeck != nil
        
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
    
    private func startStudySession() {
        guard let selectedDeck = selectedDeck,
              let folderWithCards = selectedDeck.folders.first(where: { !$0.flashcards.isEmpty }) else {
            ToastManager.shared.show(
                Toast(style: .warning, message: "No flashcards available for this deck. Create some!")
            )
            return
        }
        studySessionViewModel.startStudySession(with: folderWithCards)
    }
}




