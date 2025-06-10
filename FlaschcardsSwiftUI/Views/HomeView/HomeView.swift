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
    @Query(sort: \Deck.createdAt, order: .reverse) private var decks: [Deck]
    
    var body: some View {
        NavigationView {
            ScrollView {
                Divider()
                FlaschcardsInfo()
//                HomeFolderList(deckViewModel: deckViewModel, decks: decks)
                HomeFolderList(decks: decks)
                
                Spacer()
                //                MainButton(action: {
                //                    startStudySession()
                //                }, title: "Start")
                
                NavigationLink(destination:
                                StudySessionView()
                    .environmentObject(studySessionViewModel)
                ) {
                    Text("Start Study Session")
                        .font(.headline)
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .foregroundStyle(.white)
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding([.trailing, .leading])

                }
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
                            // Используем компонент наложенных флагов
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
            .fullScreenCover(isPresented: $studySessionViewModel.studySessionActive) {
            }
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
