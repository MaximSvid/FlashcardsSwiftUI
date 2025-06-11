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
            // progressView
            Spacer()
            HStack {
                Image(systemName: "speaker.wave.2")
                    .font(.system(size: 22))
                    .foregroundStyle(.blue)
                    .onTapGesture {
                        studySessionViewModel.speakQuestion()
                    }
                
                Text(studySessionViewModel.currentFlashcard?.question ?? "No question available")
                    .font(.title2)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .padding()
                    .foregroundStyle(.primary)
            }
                        
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .background(Color(.systemBackground))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(.systemGray4), lineWidth: 1)
        )
        .padding(.horizontal)
        .padding(.bottom)
        .onTapGesture {
            studySessionViewModel.showAnswer()
        }
    }
}
