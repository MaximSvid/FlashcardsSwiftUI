//
//  DropdownMenu.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 16.06.25.
//
import SwiftUI

struct DropdownMenuRight: View {
    @EnvironmentObject private var deckViewModel: DeckViewModel
    @EnvironmentObject private var folderViewModel: FolderViewModel
//    @Binding var isPresented: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button(action: {
                if deckViewModel.selectedDeck == nil {
                    ToastManager.shared.show(Toast(style: .info, message: "Create a deck first"))
                } else {
                    folderViewModel.showCreateFolder = true
                }
            }) {
                HStack {
                    Text("Create Folder")
                        .foregroundStyle(deckViewModel.selectedDeck == nil ? .gray : .black)
                        .font(.system(size: 16, weight: .medium))
                    
                    Spacer()
                    
                    Image(systemName: "folder.badge.plus")
                        .font(.system(size: 20))
                        .foregroundStyle(deckViewModel.selectedDeck == nil ? .gray : .black)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .contentShape(Rectangle())
            }

            
//            Divider()
//                .padding(.horizontal, 16)
//            
//            DropdownItem(title: "Settings", icon: "gear") {
//                isPresented = false
//            }
        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.white)
                .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
        )
        .frame(width: 230)
        .transition(.scale(scale: 0.95).combined(with: .opacity))
    }
}
