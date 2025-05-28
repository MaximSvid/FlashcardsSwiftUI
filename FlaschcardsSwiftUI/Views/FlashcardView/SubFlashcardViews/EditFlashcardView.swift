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
            
            if !flashcardViewModel.errorMessage.isEmpty {
                Text(flashcardViewModel.errorMessage)
                    .foregroundStyle(.red)
                    .font(.caption)
            }
            
            if !flashcardViewModel.infoMessage.isEmpty {
                Text(flashcardViewModel.infoMessage)
                    .foregroundStyle(.green)
                    .font(.caption)
                    .onAppear { print("InfoMessage shown: \(flashcardViewModel.infoMessage)") }
            }
            
            
            MainButton(action: {
                flashcardViewModel.updateFlashcard(flashcard: selectedFlashcard, context: modelContext)
                dissmiss()
            }, title: "Edit")
            .disabled(!flashcardViewModel.isFormValid) // deaktiviert den Button, wenn das Formular ungültig ist
            .opacity(flashcardViewModel.isFormValid ? 1 : 0.5) // um button ausgrauen
            
            
            Spacer()
        }
        .navigationTitle("Edit")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            flashcardViewModel.loadFlashcardForEditing(flashcard: selectedFlashcard)
        }
        .onDisappear {
            flashcardViewModel.clearEditingData()
        }
    }
}


