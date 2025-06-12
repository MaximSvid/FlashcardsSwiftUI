//
//  AnswerView.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 09.06.25.
//

import SwiftUI

struct AnswerView: View {
    @EnvironmentObject private var studySessionViewModel: StudySessionViewModel
    @EnvironmentObject private var flashcardViewModel: FlashcardViewModel
    @Environment(\.modelContext) private var modelContext
    
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 0) {
                    VStack {
                        HStack {
                            Spacer()
                            Text("\(studySessionViewModel.currentCardIndex + 1) / \(studySessionViewModel.flashcards.count)")
                                .font(.caption)
                                .foregroundStyle(.gray)
                        }
                        Spacer()
                        
                        VStack {
                            
                            
                            Text(studySessionViewModel.currentFlashcard?.question ?? "Probleme!!!")
                                .font(.caption)
                                .foregroundStyle(.gray)
                            
                            Divider()
                            
                            Text(studySessionViewModel.currentFlashcard?.answer ?? "Probleme!!!")
                                .font(.title2)
                                .foregroundStyle(.black)
                        }
                        
                        Spacer()
                    }
                    
                    
                    VStack {
                        HStack(alignment: .center) {
                            
                            DifficultyButtonAnswerView(
                                difficulty: .easy,
                                action: {
                                    if let currentFlashcard = studySessionViewModel.currentFlashcard {
                                        flashcardViewModel.saveCardDifficulty(
                                            flashcard: currentFlashcard,
                                            difficulty: CardDifficulty.easy,
                                            context: modelContext
                                        )
                                        
                                    }
                                    studySessionViewModel.nextCard()
                                }
                            )
                            
                            DifficultyButtonAnswerView(
                                difficulty: .normal,
                                action: {
                                    if let currentFlashcard = studySessionViewModel.currentFlashcard {
                                        flashcardViewModel.saveCardDifficulty(
                                            flashcard: currentFlashcard,
                                            difficulty: CardDifficulty.normal,
                                            context: modelContext
                                        )
                                    }
                                    studySessionViewModel.nextCard() }
                            )
                            
                            DifficultyButtonAnswerView(
                                difficulty: .hard,
                                action: {
                                    if let currentFlashcard = studySessionViewModel.currentFlashcard {
                                        flashcardViewModel.saveCardDifficulty(
                                            flashcard: currentFlashcard,
                                            difficulty: CardDifficulty.hard,
                                            context: modelContext
                                        )
                                    }
                                    studySessionViewModel.nextCard()
                                }
                            )
                        }
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color(.systemGray3), lineWidth: 1.5)
                    )
                }
                .padding()
                .frame(minHeight: geometry.size.height)
                .frame(maxWidth: .infinity)
            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(.systemGray4), lineWidth: 1.5)
        )
        .padding()
        .padding(.bottom, 16)
    }
}

