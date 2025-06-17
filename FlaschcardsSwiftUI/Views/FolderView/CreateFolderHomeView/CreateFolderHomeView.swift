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
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                VStack(spacing: 32) {
                    VStack(spacing: 16) {
                        ZStack {
                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: [Color.blue.opacity(0.1), Color.purple.opacity(0.1)],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 80, height: 80)
                            
                            Image(systemName: "folder.badge.plus")
                                .font(.system(size: 32, weight: .medium))
                                .foregroundStyle(
                                    LinearGradient(
                                        colors: [Color.blue, Color.purple],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
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
                        folderViewModel.createNewFolder(in: deck, context: modelContext)
                    }, title: "Crete Folder")
                    
                }
                .buttonStyle(PlainButtonStyle())
                .scaleEffect(folderViewModel.folderName.isEmpty ? 0.95 : 1.0)
                .opacity(folderViewModel.folderName.isEmpty ? 0.6 : 1.0)
//                .animation(.easeInOut(duration: 0.2), value: folderViewModel.folderName.isEmpty)
//                .disabled(folderViewModel.folderName.isEmpty)
            }
            .padding(.horizontal, 24)
            .padding(.top, 40)
            .padding(.bottom, 24)

        }
    }
}


//#Preview {
//    CreateFolderHomeView()
//}
