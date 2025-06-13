//
//  InfoCard.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 10.06.25.
//

import SwiftUI

struct InfoCard: View {
    @EnvironmentObject private var flashcardViewModel: FlashcardViewModel
    let deck: Deck
    let folder: Folder
    
    // перенести логику во viewModel
    private var totalFlashcards: Int {
        folder.flashcards.count
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
                let stats = flashcardViewModel.getDifficultyStats(for: folder)
                
                DifficultyButtonFolderList(
                    difficulty: .easy,
                    count: stats.easy,
                    action: { },
                    isDisabled: folder.flashcards.isEmpty
                )
                
                DifficultyButtonFolderList(
                    difficulty: .normal,
                    count: stats.normal,
                    action: { },
                    isDisabled: folder.flashcards.isEmpty
                )
                
                DifficultyButtonFolderList(
                    difficulty: .hard,
                    count: stats.hard,
                    action: { },
                    isDisabled: folder.flashcards.isEmpty
                )
            }
            VStack {
                StudyNowButton(folder: folder)
            }
            .frame(height: 50)
        }
        .onAppear {
            flashcardViewModel.currentFolder = folder
        }
    }
}

