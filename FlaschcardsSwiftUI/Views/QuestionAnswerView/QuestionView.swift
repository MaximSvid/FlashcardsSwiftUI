//
//  QuestionView.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 09.06.25.
//

import SwiftUI

struct QuestionView: View {
//    @EnvironmentObject private var deckViewModel: DeckViewModel
//    let folder: Folder
    @EnvironmentObject private var studySessionViewModel: StudySessionViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
//                HStack {
//                    Text("\(studySessionViewModel.currentCardIndex + 1)/\(studySessionViewModel.flashcards.count)")
//                        .font(.caption)
//                        .foregroundStyle(.gray)
//                }
                VStack {
                    Text(studySessionViewModel.currentFlashcard?.question ?? "")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .padding()
                        .foregroundStyle(.black)
                }
                
                Spacer()
                
                Button(action: {
                    studySessionViewModel.showAnswer()
                }) {
                    Text("Show answer")
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
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        
                    }) {
                        Image(systemName: "chevron.backward")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        
                    }) {
                        Image(systemName: "gear")
                    }
                }
            }
            
        }
    }
}
