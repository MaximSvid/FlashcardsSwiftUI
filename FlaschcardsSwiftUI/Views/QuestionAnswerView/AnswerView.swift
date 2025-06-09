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
        NavigationStack {
            VStack(spacing: 20) {
                
                HStack {
                    Text("\(studySessionViewModel.currentCardIndex + 1) / \(studySessionViewModel.flashcards.count)")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    Spacer()
                }
                HStack {
                    Text(studySessionViewModel.currentFlashcard?.question ?? "")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    Divider()
                    Text(studySessionViewModel.currentFlashcard?.answer ?? "")
                        .font(.headline)
                        .foregroundStyle(.black)
                }
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
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Button(action: {
                        
                    }) {
                        HStack {
                            Image("")
                            Text("Folder name")
                        }
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        
                    }) {
                        Image(systemName: "backward.circle")
                    }
                }
            }
        }
    }
}

#Preview {
    AnswerView()
}
