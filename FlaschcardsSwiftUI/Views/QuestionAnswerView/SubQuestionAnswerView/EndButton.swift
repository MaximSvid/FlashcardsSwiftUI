//
//  EndButton.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 13.06.25.
//

import SwiftUI

struct EndButton: View {
    let difficulty: CardDifficulty
    let count: Int
    let action: () -> Void
    @State private var isPressed = false
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                // Иконка с фиксированным размером
                ZStack {
                    Circle()
                        .fill(difficulty.color.opacity(0.15))
                        .frame(width: 40, height: 40)
                    
                    Image(systemName: difficulty.icon)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(difficulty.color)
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(difficulty.displayName)
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundStyle(difficulty.color)
                    
                    Text("Flashcards")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundStyle(difficulty.color.opacity(0.7))
                }
                
                Spacer()
                
                // Счетчик с фиксированным размером
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(difficulty.color.opacity(0.15))
                        .frame(width: 50, height: 32) // Фиксированный размер
                    
                    Text("\(count)")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundStyle(difficulty.color)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 70) // Фиксированная высота для всех кнопок
            .padding(.horizontal, 20)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        LinearGradient(
                            colors: [
                                difficulty.color.opacity(0.08),
                                difficulty.color.opacity(0.03)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(difficulty.color.opacity(0.25), lineWidth: 1.5)
            )
            .scaleEffect(isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: isPressed)
        }
        .buttonStyle(PlainButtonStyle())
//        .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, pressing: { pressing in
//            isPressed = pressing
//        }, perform: {})
        .shadow(color: difficulty.color.opacity(0.12), radius: 6, x: 0, y: 3)
    }
}
