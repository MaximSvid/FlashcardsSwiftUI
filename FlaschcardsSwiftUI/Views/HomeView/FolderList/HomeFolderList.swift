//
//  HomeFolderList.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 10.06.25.
//

import SwiftUI
import SwiftData

struct HomeFolderList: View {
    @EnvironmentObject private var deckViewModel: DeckViewModel
    let decks: [Deck]
    
    // Получаем выбранную колоду
    private var selectedDeck: Deck? {
        decks.first(where: { $0.targetLanguage == deckViewModel.selectedLanguage })
    }
    
    // Получаем первую папку с карточками
    private var selectedFolder: Folder? {
        selectedDeck?.folders.first(where: { !$0.flashcards.isEmpty })
    }
    
    var body: some View {
        // Показываем только если есть выбранная колода и папка с карточками
        if let deck = selectedDeck, let folder = selectedFolder {
            VStack {
                ForEach(deck.folders, id: \.id) {folder in
//                    if !folder.flashcards.isEmpty {
                        InfoCard(deck: deck, folder: folder)
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color(.systemBackground))
                                    .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 2)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color(.systemGray5), lineWidth: 1)
                            )
                            .padding(.horizontal)
//                    }
                }
            }
            .padding(.top)
        }
    }
}
