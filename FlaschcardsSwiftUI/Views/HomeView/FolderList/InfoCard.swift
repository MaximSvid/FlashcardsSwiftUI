//
//  InfoCard.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 10.06.25.
//

import SwiftUI

struct InfoCard: View {
    let deck: Deck
    let folder: Folder
    
    // ошибка - неверная передача количества элементов!!!
    private var totalFlashcards: Int {
        folder.flashcards.count
    }
    
    // Статистика по сложности карточек
    private var difficultyStats: (easy: Int, normal: Int, hard: Int) {
        let allCards = deck.folders.flatMap { $0.flashcards }
        return (
            easy: allCards.reduce(0) { $0 + $1.easyCount },
            normal: allCards.reduce(0) { $0 + $1.normalCount },
            hard: allCards.reduce(0) { $0 + $1.hardCount }
        )
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {

            HStack {
                OverlappingFlags(
                    native: deck.sourceLanguage ?? .english,
                    target: deck.targetLanguage ?? .english)
                                
                HStack {
                    Text(" Folder: ")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundStyle(.gray)
                    Text(folder.name)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(.black)

                    Spacer()
                }
                            }
            Divider()
                .background(Color(.systemGray4))

            
            // Flashcards Count Section
            HStack {
                Image(systemName: "rectangle.stack.fill")
                    .font(.system(size: 16))
                    .foregroundStyle(.blue)
                
                Text("Flashcards:")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(.secondary)
                
                Text(totalFlashcards == 0 ? "No flashcards" : "\(totalFlashcards)")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(.black)
                
                Spacer()
            }
            
            // Difficulty Buttons Section
            
            HStack(spacing: 12) {
                DifficultyButtonFolderList(
                    difficulty: .easy,
                    count: difficultyStats.easy,
                    action: {  },
                    isDisabled: folder.flashcards.isEmpty
                )
                
                DifficultyButtonFolderList(
                    difficulty: .normal,
                    count: difficultyStats.normal,
                    action: {  },
                    isDisabled: folder.flashcards.isEmpty
                )
                
                DifficultyButtonFolderList(
                    difficulty: .hard,
                    count: difficultyStats.hard,
                    action: {  },
                    isDisabled: folder.flashcards.isEmpty
                )
            }
            
            VStack {
                StudyNowButton(folder: folder)
            }
            .frame(height: 50)
        }
    }
}

