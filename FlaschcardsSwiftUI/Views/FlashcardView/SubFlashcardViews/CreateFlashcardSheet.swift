//
//  CreateFlashcardSheet.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 23.05.25.
//

import SwiftUI
import AlertToast


struct CreateFlashcardSheet: View {
    @EnvironmentObject private var flashcardViewModel: FlashcardViewModel
    @EnvironmentObject private var folderViewModel: FolderViewModel
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    var selectedFolder: Folder?
    
    var body: some View {
        VStack {
            Text("Folder: \(selectedFolder?.name ?? "No folder selected")")
                .font(.title3.bold())
                .padding()
            
            ZStack(alignment: .topLeading) {
                TextEditor(text: $flashcardViewModel.question)
                    .frame(maxHeight: 100)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(style: StrokeStyle(lineWidth: 0.5))
                    )
                    .padding()
                
                if flashcardViewModel.question.isEmpty {
                    Text("Question")
                        .foregroundStyle(.gray)
                        .padding()
                        .padding(.top, 8)
                        .padding(.leading, 8)
                        .allowsHitTesting(false) // um nichts clicable zu blockieren
                }
            }
            
            ZStack(alignment: .topLeading) {
                TextEditor(text: $flashcardViewModel.answer)
                    .frame(maxHeight: 100)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(style: StrokeStyle(lineWidth: 0.5))
                    )
                    .padding()
                
                if flashcardViewModel.answer.isEmpty {
                    Text("Answer")
                        .foregroundStyle(.gray)
                        .padding()
                        .padding(.top, 8)
                        .padding(.leading, 8)
                        .allowsHitTesting(false) // um nichts clicable zu blockieren
                    
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
                if let folder = selectedFolder {
                    flashcardViewModel.createNewFlashcard(in: folder, context: modelContext)
                    flashcardViewModel.toastMessageIfFlashcardCreated = true
                    dismiss()
                }
                
            }, title: "Create")
            .disabled(!flashcardViewModel.isFormValid) // deaktiviert den Button, wenn das Formular ungültig ist
            .opacity(flashcardViewModel.isFormValid ? 1 : 0.5) // um button ausgrauen
            
            Spacer()
        }
        .toast(isPresenting: $flashcardViewModel.toastMessageIfFlashcardCreated, duration: 2, tapToDismiss: true) {
            AlertToast(type: .complete(.green), title: "Flashcard Created!")
        }
        .onAppear {
            if let folder = selectedFolder {
                flashcardViewModel.currentFolder = folder
            }
        }
        .onDisappear {
            flashcardViewModel.clearEditingData()
//            flashcardViewModel.toastMessageIfFlashcardCreated = false
        }
        
    }
}
