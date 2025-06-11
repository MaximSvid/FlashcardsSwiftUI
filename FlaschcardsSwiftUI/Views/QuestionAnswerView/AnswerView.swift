//
//  AnswerView.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 09.06.25.
//

import SwiftUI

struct AnswerView: View {
    @EnvironmentObject private var studySessionViewModel: StudySessionViewModel
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 0) {
                    VStack {
                        Spacer()
                        
                        VStack {
                            HStack {
                                Text("\(studySessionViewModel.currentCardIndex + 1) / \(studySessionViewModel.flashcards.count)")
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                            }
                            
                            Text(studySessionViewModel.currentFlashcard?.question ?? "Probleme!!!")
                                .font(.caption)
                                .foregroundStyle(.gray)
                            
                            Divider()
                            
                            Text(studySessionViewModel.currentFlashcard?.answer ?? "Probleme!!!")
                                .font(.headline)
                                .foregroundStyle(.black)
                        }
                        
                        Spacer()
                    }
                    
                    
                    VStack {
                        HStack(alignment: .center) {
                            
                            DifficultyButtonAnswerView(
                                difficulty: .easy,
                                action: {studySessionViewModel.nextCard()}
                            )
                            
                            DifficultyButtonAnswerView(
                                difficulty: .normal,
                                action: { studySessionViewModel.nextCard() }
                            )
                            
                            DifficultyButtonAnswerView(
                                difficulty: .hard,
                                action: { studySessionViewModel.nextCard() }
                            )
                        }
//                        .padding(.bottom)
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
                .stroke(Color(.systemGray4), lineWidth: 0.5)
        )
        .padding()
        .padding(.bottom, 16)
    }
}

