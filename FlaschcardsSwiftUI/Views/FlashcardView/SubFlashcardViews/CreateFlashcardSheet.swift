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
                HStack(alignment: .center, spacing: 8) {
                    Image(systemName: flashcardViewModel.errorIcon)
                        .foregroundStyle(.red)
                    Text(flashcardViewModel.errorMessage)
                        .foregroundStyle(.red)
                        .font(.caption)
                }
                .padding(.horizontal)
            }
            
            if !flashcardViewModel.infoMessage.isEmpty {
                HStack(alignment: .center, spacing: 8) {
                    Image(systemName: flashcardViewModel.infoIcon)
                        .foregroundStyle(flashcardViewModel.infoIcon == "checkmark.circle.fill" ? .green : .blue)
                    Text(flashcardViewModel.infoMessage)
                        .foregroundStyle(flashcardViewModel.infoIcon == "checkmark.circle.fill" ? .green : .blue)
                        .font(.caption)
                }
                .padding(.horizontal)
                .onAppear { print("InfoMessage shown: \(flashcardViewModel.infoMessage)") }
            }
            MainButton(action: {
                if let folder = selectedFolder {
                    flashcardViewModel.createNewFlashcard(in: folder, context: modelContext)
                    //                    flashcardViewModel.toastMessageIfFlashcardCreated = true
                    dismiss()
                }
                
            }, title: "Create")
            .disabled(!flashcardViewModel.isFormValid) // deaktiviert den Button, wenn das Formular ungültig ist
            .opacity(flashcardViewModel.isFormValid ? 1 : 0.5) // um button ausgrauen
            
            Spacer()
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
