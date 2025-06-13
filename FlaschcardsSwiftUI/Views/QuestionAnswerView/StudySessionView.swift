//
//  StudySessionView.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 09.06.25.
//

import SwiftUI

struct StudySessionView: View {
    @EnvironmentObject private var studySessionViewModel: StudySessionViewModel
    @EnvironmentObject private var flashcardViewModel: FlashcardViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                if studySessionViewModel.isSessionFinished {
                    EndAnswerQuestionView(selectedFolder: studySessionViewModel.currentFolder)
                        .environmentObject(flashcardViewModel)
                } else if studySessionViewModel.showingAnswer {
                    AnswerView()
                } else {
                    QuestionView()
                }
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Study Session")
                        .font(.headline)
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        studySessionViewModel.endStudySession()
                        dismiss()
                    }) {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                    }
                }
            }
//            .onAppear {
            // убирает вообще количесво изученых карточек
//                //синхронизация папок
//                flashcardViewModel.currentFolder = studySessionViewModel.currentFolder
//            }
        }
        .navigationViewStyle(StackNavigationViewStyle()) // Принудительно используем стек
    }
}


