//
//  DifficultyButton.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 10.06.25.
//

import SwiftUI

struct DifficultyButtonFolderList: View {
    let difficulty: CardDifficulty
    let count: Int
    let action: () -> Void
    let isDisabled: Bool
    
    @State private var isPressed = false
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 6) {
                Image(systemName: difficulty.icon)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(isDisabled ? .gray :difficulty.color)
                
                Text(difficulty.displayName)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(isDisabled ? .gray :difficulty.color)
                
                // Count badge
                Text("\(count)")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundStyle(.white)
                    .frame(minWidth: 20, minHeight: 16)
                    .background(isDisabled ? .gray :difficulty.color)
                    .clipShape(Capsule())
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .padding(.horizontal, 8)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill((isDisabled ? Color.gray : difficulty.color).opacity(isPressed ? 0.2 : 0.1))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke((isDisabled ? Color.gray : difficulty.color).opacity(0.3), lineWidth: 1)
                    )
            )
            .scaleEffect(isPressed ? 0.95 : 1.0)
        }
        .buttonStyle(PlainButtonStyle())
        .disabled(isDisabled)
        //        .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity) { isPressing in
        //            withAnimation(.easeInOut(duration: 0.1)) {
        //                isPressed = isPressing
        //            }
        //        } perform: {
        //            action()
        //        }
    }
}
