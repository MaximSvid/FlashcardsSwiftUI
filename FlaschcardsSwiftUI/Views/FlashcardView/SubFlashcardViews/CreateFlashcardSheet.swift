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
            
            CustomTextEditor(placeholder: "Question", text: $flashcardViewModel.question)
                .padding()
            CustomTextEditor(placeholder: "Answer", text: $flashcardViewModel.answer)
                .padding()
            
            MainButton(action: {
                if let folder = selectedFolder {
                    flashcardViewModel.createNewFlashcard(in: folder, context: modelContext)
                    dismiss()
                }
                
            }, title: "Create")
                
        }
    }
}

#Preview {
    CreateFlashcardSheet()
}
