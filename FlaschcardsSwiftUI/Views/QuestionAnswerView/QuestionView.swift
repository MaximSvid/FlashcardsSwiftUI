//
//  QuestionView.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 09.06.25.
//

import SwiftUI

struct QuestionView: View {
    @EnvironmentObject private var studySessionViewModel: StudySessionViewModel

    var body: some View {
        VStack {
            Spacer()
            
            // Main question content
            VStack {
                HStack {
                    Button(action: {
//                        studySessionViewModel.speakQuestion()
                        studySessionViewModel.toggleSound()
                    }) {
                        Image(systemName: studySessionViewModel.soundIconName)
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundStyle(.blue.opacity(0.8))
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.trailing, 8)
                    
                    Text(studySessionViewModel.currentFlashcard?.question ?? "No question available")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.primary)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                }
//                .padding(.horizontal, 20)
                .padding([.leading, .trailing])
                .padding(.vertical, 16)
                
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .background(Color(.systemBackground))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color(.systemGray3), lineWidth: 1.5)
        )
//        .padding(.horizontal, 16)
        .padding()
        .padding(.bottom, 16)
        .onTapGesture {
            studySessionViewModel.showAnswer()
        }
        .onAppear {
            // Автоматическое воспроизведение через полсекунды после появления
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                studySessionViewModel.speakQuestionIfEnabled()
            }
        }
        .onChange(of: studySessionViewModel.currentCardIndex) { _, _ in
            // Автоматическое воспроизведение при смене карточки
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                studySessionViewModel.speakQuestionIfEnabled()
            }
        }
    }
}
