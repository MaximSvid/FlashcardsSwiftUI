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
        GeometryReader { geometry in
            HStack {
                Spacer()
                Text("\(studySessionViewModel.currentCardIndex + 1) / \(studySessionViewModel.flashcards.count)")
                    .font(.caption)
                    .foregroundStyle(.gray)
                
            }
            .padding([.vertical, .horizontal],  20) // может добавить эту информацию в Toolbar?
            
            ScrollView {
                VStack {
                    HStack {
                        Button(action: {
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
                    .padding([.leading, .trailing])
                    .padding(.vertical, 16)
                }
                .frame(minHeight: geometry.size.height) // Минимальная высота = высота экрана
                .frame(maxWidth: .infinity)
            }
        }
        .background(Color(.systemBackground))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(.systemGray3), lineWidth: 1.5)
        )
        .padding()
        .padding(.bottom, 16)
        .onTapGesture {
            studySessionViewModel.showAnswer()
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                studySessionViewModel.speakQuestionIfEnabled()
            }
        }
        .onChange(of: studySessionViewModel.currentCardIndex) { _, _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                studySessionViewModel.speakQuestionIfEnabled()
            }
        }
    }
}
