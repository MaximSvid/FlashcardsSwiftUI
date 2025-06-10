//
//  AnswerView.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 09.06.25.
//

import SwiftUI

struct AnswerView: View {
    @EnvironmentObject private var studySessionViewModel: StudySessionViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            HStack {
                Text("\(studySessionViewModel.currentCardIndex + 1) / \(studySessionViewModel.flashcards.count)")
                    .font(.caption)
                    .foregroundStyle(.gray)
                Spacer()
            }
            
            Text(studySessionViewModel.currentFlashcard?.question ?? "Probleme!!!")
                .font(.caption)
                .foregroundStyle(.gray)
            Divider()
            Text(studySessionViewModel.currentFlashcard?.answer ?? "Probleme!!!")
                .font(.headline)
                .foregroundStyle(.black)
            
            Spacer()
            
            HStack {
                DifficultyButtonView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(style: StrokeStyle(lineWidth: 1))
        )
    }
}

