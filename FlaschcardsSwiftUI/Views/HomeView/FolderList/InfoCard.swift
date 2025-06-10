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
            
//            HStack(spacing: 16) {
                // Source Language
//                HStack(spacing: 8) {
//                    Text(deck.sourceLanguage?.imageName ?? "🌐")
//                        .font(.system(size: 28))
//                        .frame(width: 32, height: 32)
//                    
//                    Text(deck.sourceLanguage?.displayName ?? "Unknown")
//                        .font(.system(size: 16, weight: .semibold))
//                        .foregroundStyle(.primary)
//                }
                
                // Arrow with animation potential
//                Image(systemName: "arrow.right")
//                    .font(.system(size: 14, weight: .medium))
//                    .foregroundStyle(.secondary)
//                    .frame(minWidth: 20)
//                
//                // Target Language
//                HStack(spacing: 8) {
//                    Text(deck.targetLanguage?.imageName ?? "🌐")
//                        .font(.system(size: 28))
//                        .frame(width: 32, height: 32)
//                    
//                    Text(deck.targetLanguage?.displayName ?? "Unknown")
//                        .font(.system(size: 16, weight: .semibold))
//                        .foregroundStyle(.primary)
//                }
//                
//                Spacer()
//            }
            
            // Divider for visual separation
//            Divider()
//                .background(Color(.systemGray4))

            HStack {
                OverlappingFlags(
                    native: deck.sourceLanguage ?? .english,
                    target: deck.targetLanguage ?? .english)
                Image(systemName: "")
                    .font(.system(size: 16))
                    .foregroundStyle(.gray)
                Text(" Folder: \(folder.name)")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(.black)
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
                DifficultyButton(
                    difficulty: .easy,
                    count: difficultyStats.easy,
                    action: {  }
                )
                
                DifficultyButton(
                    difficulty: .normal,
                    count: difficultyStats.normal,
                    action: {  }
                )
                
                DifficultyButton(
                    difficulty: .hard,
                    count: difficultyStats.hard,
                    action: {  }
                )
            }
            
            VStack {
                StudyNowButton(folder: folder)
            }
            .frame(height: 50)
        }
    }
}

