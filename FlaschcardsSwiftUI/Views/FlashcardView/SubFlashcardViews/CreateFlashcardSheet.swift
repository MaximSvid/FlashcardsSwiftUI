//
//  CreateFlashcardSheet.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 23.05.25.
//

import SwiftUI

struct CreateFlashcardSheet: View {
    @EnvironmentObject private var flashcardViewModel: FlashcardViewModel
    @EnvironmentObject private var folderViewModel: FolderViewModel
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    var selectedFolder: Folder?
    
    var body: some View {
        VStack {
            Text("Folder: ")
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
            
            
            MainButton(action: {
                if let folder = selectedFolder {
                    flashcardViewModel.createNewFlashcard(in: folder, context: modelContext)
                    dismiss()
                }
                
            }, title: "Create")
            
            Spacer()
            
        }
    }
}

#Preview {
    CreateFlashcardSheet()
}
