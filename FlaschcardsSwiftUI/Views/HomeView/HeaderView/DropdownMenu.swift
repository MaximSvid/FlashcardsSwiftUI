//
//  DropdownMenu.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 16.06.25.
//
import SwiftUI

struct DropdownMenu: View {
    @EnvironmentObject private var deckViewModel: DeckViewModel
    @Binding var isPresented: Bool
    @Binding var showCreateFolder: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button(action: {
                withAnimation(.easeInOut(duration: 0.2)) {
                    isPresented = false
                }
                // Небольшая задержка для плавной анимации
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    showCreateFolder = true
                }
            }) {
                HStack {
                    Text("Create Folder")
                        .foregroundStyle(.primary)
                        .font(.system(size: 16, weight: .medium))
                    
                    Spacer()
                    
                    Image(systemName: "folder.badge.plus")
                        .font(.system(size: 20))
                        .foregroundStyle(.primary)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .contentShape(Rectangle())
            }
            
            Divider()
                .padding(.horizontal, 16)
            
            DropdownItem(title: "Settings", icon: "gear") {
                isPresented = false
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.white)
                .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
        )
        .frame(width: 230)
        .transition(.scale(scale: 0.95).combined(with: .opacity))
        .sheet(isPresented: $showCreateFolder) {
            CreateFolderHomeView(
                deck: deckViewModel.selectedDeck ?? Deck(
                    id: UUID(),
                    folders: [],
                    createdAt: Date(),
                    targetLanguage: .english,
                    sourceLanguage: .english
                )
            )
            .presentationDragIndicator(.visible)
        }
    }
}
