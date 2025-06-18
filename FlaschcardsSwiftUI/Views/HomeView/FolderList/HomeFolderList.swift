//
//  HomeFolderList.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 10.06.25.
//

import SwiftUI
import SwiftData

struct HomeFolderList: View {
    let deck: Deck
    @EnvironmentObject private var deckViewModel: DeckViewModel
    @EnvironmentObject private var folderViewModel: FolderViewModel
    @EnvironmentObject private var flashcardViewModel: FlashcardViewModel
    @EnvironmentObject private var studySessionViewModel: StudySessionViewModel

    var body: some View {
        VStack {
            ForEach(deck.folders, id: \.self) { folder in
                InfoCard(deck: deck, folder: folder) // Убедитесь, что InfoCard принимает folder: Folder
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
            }
        }
        .padding(.top)
    }
}
