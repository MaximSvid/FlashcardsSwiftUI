//
//  InfoCard.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 10.06.25.
//

import SwiftUI

struct InfoCard: View {
    let deck: Deck
    
    // Правильный подсчет всех карточек во всех папках
    private var totalFlashcards: Int {
        deck.folders.reduce(0) { total, folder in
            total + folder.flashcards.count
        }
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
            // Language Section with improved design
            HStack(spacing: 16) {
                // Source Language
                HStack(spacing: 8) {
                    Text(deck.sourceLanguage?.imageName ?? "🌐")
                        .font(.system(size: 28))
                        .frame(width: 32, height: 32)
//                        .background(Color(.systemGray6))
//                        .clipShape(Circle())
                    
                    Text(deck.sourceLanguage?.displayName ?? "Unknown")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.primary)
                }
                
                // Arrow with animation potential
                Image(systemName: "arrow.right")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(.secondary)
                    .frame(minWidth: 20)
                
                // Target Language
                HStack(spacing: 8) {
                    Text(deck.targetLanguage?.imageName ?? "🌐")
                        .font(.system(size: 28))
                        .frame(width: 32, height: 32)
//                        .background(Color(.systemGray6))
//                        .clipShape(Circle())
                    
                    Text(deck.targetLanguage?.displayName ?? "Unknown")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.primary)
                }
                
                Spacer()
            }
            
            // Divider for visual separation
            Divider()
                .background(Color(.systemGray4))
            
            // Flashcards Count Section
            HStack {
                Image(systemName: "rectangle.stack.fill")
                    .font(.system(size: 16))
                    .foregroundStyle(.green)
                
                Text("Flashcards:")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(.secondary)
                
                Text("\(totalFlashcards)")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(.primary)
                
                Spacer()
                
                // Optional: Show folders count
                if deck.folders.count > 1 {
                    Text("(\(deck.folders.count) folders)")
                        .font(.system(size: 13))
                        .foregroundStyle(.tertiary)
                }
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
        }
    }
}

struct DifficultyButton: View {
    let difficulty: CardDifficulty
    let count: Int
    let action: () -> Void
    
    @State private var isPressed = false
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 6) {
                Image(systemName: difficulty.icon)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(difficulty.color)
                
                Text(difficulty.displayName)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(difficulty.color)
                
                // Count badge
                Text("\(count)")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundStyle(.white)
                    .frame(minWidth: 20, minHeight: 16)
                    .background(difficulty.color)
                    .clipShape(Capsule())
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .padding(.horizontal, 8)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(difficulty.color.opacity(isPressed ? 0.2 : 0.1))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(difficulty.color.opacity(0.3), lineWidth: 1)
                    )
            )
            .scaleEffect(isPressed ? 0.95 : 1.0)
        }
        .buttonStyle(PlainButtonStyle())
        .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity) { isPressing in
            withAnimation(.easeInOut(duration: 0.1)) {
                isPressed = isPressing
            }
        } perform: {
            action()
        }
    }
}
