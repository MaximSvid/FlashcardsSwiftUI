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
                FlaschcardsInfo()
                
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
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        //action
                    }) {
                        Image(systemName: "paintpalette")
                            .foregroundStyle(.gray)
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Button(action: {
                        deckViewModel.newDeckSheetIsPresented = true
                    }) {
                        HStack(spacing: 8) {
                            if decks.contains(where: { $0.targetLanguage == deckViewModel.selectedLanguage }) {
                                OverlappingFlags(
                                    native: deckViewModel.selectedSourceLanguage,
                                    target: deckViewModel.selectedLanguage,
                                    size: 20
                                )
                            } else {
                                Text("🌐")
                                    .font(.system(size: 20))
                            }
                            
                            Text(decks.contains { $0.targetLanguage == deckViewModel.selectedLanguage }
                                 ? deckViewModel.selectedLanguage.rawValue
                                 : "Create a deck")
                            .foregroundStyle(.black.opacity(0.8))
                            .font(.system(size: 16, weight: .medium))
                            
                            Image(systemName: "chevron.down")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundStyle(.black.opacity(0.6))
                        }
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        //action
                    }) {
                        Image(systemName: "chart.bar")
                            .foregroundStyle(.gray)
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
//            .fullScreenCover(isPresented: $studySessionViewModel.studySessionActive) {
//                EndAnswerQuestionView() // Предполагается, что это представление отображается
//                    .environmentObject(deckViewModel)
//                    .environmentObject(folderViewModel) // Добавлено
//                    .environmentObject(flashcardViewModel)
//                    .environmentObject(studySessionViewModel)
//            }
        }
    }
    
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

