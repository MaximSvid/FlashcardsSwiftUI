//
//  DropdownItem.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 16.06.25.
//
import SwiftUI

struct DropdownItem: View {
    let title: String
    let icon: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Text(title)
                    .foregroundStyle(.primary)
                    .font(.system(size: 16, weight: .medium))
                
                Spacer()
                
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundStyle(.primary)
//                    .frame(width: 20)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
        .background(
            Rectangle()
                .fill(.gray.opacity(0.05))
                .opacity(0) // прозрачный фон, который появляется при нажатии
        )
    }
}
