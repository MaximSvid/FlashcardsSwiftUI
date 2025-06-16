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
    
    
    // Проверяем есть ли папки с карточками
    private var hasAvailableFolders: Bool {
        guard let selectedDeck = decks.first(where: { $0.targetLanguage == deckViewModel.selectedLanguage }) else {
            return false
        }
        return selectedDeck.folders.contains { !$0.flashcards.isEmpty }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                //                FlaschcardsInfo()
                
                // Показываем HomeFolderList только если есть папки с карточками
                if hasAvailableFolders {
                    HomeFolderList(decks: decks)
                        .environmentObject(deckViewModel)
                        .environmentObject(folderViewModel)
                } else {
                    // Показываем placeholder если нет папок
                    EmptyFoldersPlaceholder()
                }
                
                Spacer()
                
                    .disabled(!hasAvailableFolders) // Отключаем кнопку если нет карточек
                    .padding(.bottom, 30)
            }
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.blue.opacity(0.03))
            .toolbar {
                toolbarContent()
            }
            .overlay {
                // для замыливания заднего фона
                if showingDropdown {
                    Color.black.opacity(0.1)
                        .ignoresSafeArea(.all)
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                showingDropdown = false
                            }
                        }
                        .overlay(alignment: .topTrailing) {
                            DropdownMenu(isPresented: $showingDropdown)
                                .padding(.top, 30)
                                .padding(.trailing, 16)
                        }
                }
            }
            .toolbarBackground(Color.white, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .sheet(isPresented: $deckViewModel.newDeckSheetIsPresented) {
                NewDeckSheet()
                    .environmentObject(deckViewModel)
                    .presentationDragIndicator(.visible)
                    .withRootToast()
            }
        }
    }
    
    @ToolbarContentBuilder
    private func toolbarContent() -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            
        }
        
        ToolbarItem(placement: .principal) {
            principalToolbarButton()
        }
        
        ToolbarItem(placement: .topBarTrailing) {
            Button(action: {
                showingDropdown.toggle()
            }) {
                Image(systemName: "ellipsis")
                    .foregroundStyle(.gray)
                    .overlay(
                        Circle()
                            .fill(.gray.opacity(0.1))
                    )
            }
        }
    }
    
    //move to mvvm?
    private func principalToolbarButton() -> some View {
        let hasSelectedDeck = decks.contains(where: { $0.targetLanguage == deckViewModel.selectedLanguage })
        
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
    
    //move to viewModel
    private func startStudySession() {
        guard let selectedDeck = decks.first(where: { $0.targetLanguage == deckViewModel.selectedLanguage}),
              let folderWithCards = selectedDeck.folders.first(where: { !$0.flashcards.isEmpty}) else {
            ToastManager.shared.show(
                Toast(style: .warning, message: "No flashcards available for this deck. Create some!")
            )
            return
        }
        studySessionViewModel.startStudySession(with: folderWithCards)
    }
}

struct DropdownMenu: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            DropdownItem(title: "Create Folder", icon: "folder.badge.plus") {
                // действие создания папки
                isPresented = false
            }
            
            Divider()
                .padding(.horizontal, 16)
            
            DropdownItem(title: "Import Cards", icon: "square.and.arrow.down") {
                // действие импорта карточек
                isPresented = false
            }
            
            Divider()
                .padding(.horizontal, 16)
            
            DropdownItem(title: "Settings", icon: "gear") {
                // действие настроек
                isPresented = false
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.white)
                .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
        )
        .frame(width: 200)
        .transition(.scale(scale: 0.95).combined(with: .opacity))
        .onTapGesture {
            // предотвращаем закрытие при тапе по меню
        }
        .background(
            // Невидимый фон для закрытия меню при тапе вне его
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        isPresented = false
                    }
                }
                .ignoresSafeArea()
        )
    }
}

struct DropdownItem: View {
    let title: String
    let icon: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .foregroundStyle(.blue)
                    .frame(width: 20)
                
                Text(title)
                    .foregroundStyle(.primary)
                    .font(.system(size: 16, weight: .medium))
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
        .background(
            Rectangle()
                .fill(.gray.opacity(0.05))
                .opacity(0) // прозрачный фон, который появляется при нажатии
        )
    }
}
