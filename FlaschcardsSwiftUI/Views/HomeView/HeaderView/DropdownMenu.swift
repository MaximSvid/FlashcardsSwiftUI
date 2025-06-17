//
//  DropdownMenu.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 16.06.25.
//
import SwiftUI

struct DropdownMenu: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            DropdownItem(title: "Create Folder", icon: "folder.badge.plus") {
                // действие создания папки
                isPresented = false
            }
            
//            Divider()
//                .padding(.horizontal, 16)
            
//            DropdownItem(title: "Import Cards", icon: "square.and.arrow.down") {
//                // действие импорта карточек
//                isPresented = false
//            }
            
            Divider()
                .padding(.horizontal, 16)
            
            DropdownItem(title: "Settings", icon: "gear") {
                // действие настроек
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
        .onTapGesture {
            // предотвращаем закрытие при тапе по меню
        }
        .background(
            // Невидимый фон для закрытия меню при тапе вне его
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        isPresented = false
                    }
                }
                .ignoresSafeArea()
        )
    }
}
