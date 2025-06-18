//
//  CreateFolderHomeView.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 17.06.25.
//

import SwiftUI

struct CreateFolderHomeView: View {
    @EnvironmentObject private var folderViewModel: FolderViewModel
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    var deck: Deck
    @Binding var showCreateFolder: Bool
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                VStack(spacing: 32) {
                    VStack(spacing: 16) {
                        ZStack {
                            Circle()
                                .fill(
                                    Color.blue.opacity(0.1)
                                )
                                .frame(width: 80, height: 80)
                            
                            Image(systemName: "folder.badge.plus")
                                .font(.system(size: 32, weight: .medium))
                                .foregroundStyle(
                                    Color.blue.opacity(0.8)
                                )
                        }
                        
                        VStack(spacing: 8) {
                            Text("Create New Folder")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)
                            
                            Text("Organize your cards into folders")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Folder Name")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(.secondary)
                        
                        CustomTextField(placeholder: "Enter folder name", text: $folderViewModel.folderName)
                    }
                    
                    Spacer()
                    
                    MainButton(action: {
                        if !folderViewModel.folderName.isEmpty {
                            folderViewModel.createNewFolder(in: deck, context: modelContext) // работает неправильно
                            showCreateFolder = false
                            ToastManager.shared.show(Toast(style: .info, message: "Folder created successfully!"))

                        } else {
                            ToastManager.shared.show(Toast(style: .info, message: "Folfer name can not be empty!"))
                        }
                                                
                    }, title: "Crete Folder")
                    
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.horizontal, 16)
            .padding(.top, 40)
            .padding(.bottom, 24)

        }
    }
}


//#Preview {
//    CreateFolderHomeView()
//}
