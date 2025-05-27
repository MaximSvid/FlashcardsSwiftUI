//
//  EditFlashcardView.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 27.05.25.
//

import SwiftUI

struct EditFlashcardView: View {
    @EnvironmentObject private var flashcardViewModel: FlashcardViewModel
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dissmiss
    
    let selectedFlashcard: Flashcard
    
    var body: some View {
        VStack {
            
            ZStack(alignment: .topLeading) {
                TextEditor(text: $flashcardViewModel.question)
                    .frame(maxHeight: 100)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray, style:  StrokeStyle(lineWidth: 0.5))
                    )                    .padding()
                
                if flashcardViewModel.question.isEmpty {
                    Text("Question")
                        .foregroundStyle(.gray)
                        .padding()
                        .padding([.top, .leading], 8)
                        .allowsHitTesting(false)
                }
            }
            
            ZStack(alignment: .topLeading) {
                TextEditor(text: $flashcardViewModel.answer)
                    .frame(maxHeight: 100)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray, style:  StrokeStyle(lineWidth: 0.5))
                    )
                    .padding()
                
                if flashcardViewModel.answer.isEmpty {
                    Text("Answer")
                        .foregroundStyle(.gray)
                        .padding()
                        .padding([.top, .leading], 8)
                        .allowsHitTesting(false)
                }
            }
            
            MainButton(action: {
                flashcardViewModel.updateFlashcard(flashcard: selectedFlashcard, context: modelContext)
                dissmiss()
            }, title: "Edit")
            
            Spacer()
        }
        .navigationTitle("Edit")
        .onAppear {
            flashcardViewModel.loadFlashcardForEditing(flashcard: selectedFlashcard)
        }
        .onDisappear {
            flashcardViewModel.clearEditingData()
        }
    }
}


