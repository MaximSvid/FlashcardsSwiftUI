//
//  EndAnswerQuestionView.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 13.06.25.
//

import SwiftUI

struct EndAnswerQuestionView: View {
    @EnvironmentObject private var folderViewModel: FolderViewModel
    @EnvironmentObject private var flashcardViewModel: FlashcardViewModel
    var selectedFolder: Folder?
    @EnvironmentObject private var studySessionViewModel: StudySessionViewModel
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 0) {
                    Spacer() // move to center
                    
                    VStack(spacing: 16) {
                        
                        EndButton(
                            difficulty: .easy,
                            count: flashcardViewModel.difficultyStats.easy,
                            action: {
                                studySessionViewModel.startStudySessionWithDifficulty(.easy)
                            }
                        )
                        
                        EndButton(
                            difficulty: .normal,
                            count: flashcardViewModel.difficultyStats.normal,
                            action: {
                                studySessionViewModel.startStudySessionWithDifficulty(.normal)
                            }
                        )
                        
                        EndButton(
                            difficulty: .hard,
                            count: flashcardViewModel.difficultyStats.hard,
                            action: {
                                studySessionViewModel.startStudySessionWithDifficulty(.hard)
                            }
                        )
                    }
                    .padding(.horizontal, 20)
                    
                    // Дополнительные кнопки
                    VStack(spacing: 12) {
                        Button(action: {
                            studySessionViewModel.restartSession()
                        }) {
                            Text("Repeat All")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 60)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.blue)
                                )
                        }
                        .padding(.bottom, 12)
                        .buttonStyle(PlainButtonStyle())
                        
                        Button(action: {
//                            studySessionViewModel.startNextFolderStudySession() // не работает - 
                        }) {
                            Text("Next Folder")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 60) 
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.green)
                                )
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 32)
                    
                    Spacer() // move to center
                }
                .frame(minHeight: geometry.size.height)
            }
        }
    }
}
