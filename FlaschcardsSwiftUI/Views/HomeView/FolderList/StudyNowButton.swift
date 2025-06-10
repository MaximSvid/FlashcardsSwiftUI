//
//  StudyNowButton.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 10.06.25.
//

import SwiftUI

struct StudyNowButton: View {
    let folder: Folder
    @EnvironmentObject private var studySessionViewModel: StudySessionViewModel
    @EnvironmentObject private var flashcardViewModel: FlashcardViewModel
    @State private var showCreateFlashcard = false
    
    var body: some View {
        Button(action: {
            if folder.flashcards.isEmpty {
                // Переходим к созданию карточки
                flashcardViewModel.currentFolder = folder
                showCreateFlashcard = true
            } else {
                // Начинаем изучение
                studySessionViewModel.startStudySession(with: folder)
            }
        }) {
            if folder.flashcards.isEmpty {
                Text("Create flashcards")
                    .font(.headline)
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .foregroundStyle(.white)
                    .background(Color.green.opacity(0.9))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            } else {
                Text("Study Now")
                    .font(.headline)
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .foregroundStyle(.white)
                    .background(Color.blue.opacity(0.9))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
        .sheet(isPresented: $showCreateFlashcard) {
            CreateFlashcardSheet(selectedFolder: folder)
                .environmentObject(flashcardViewModel)
        }
        .fullScreenCover(isPresented: $studySessionViewModel.studySessionActive) {
            StudySessionView()
                .environmentObject(studySessionViewModel)
        }
    }
}

