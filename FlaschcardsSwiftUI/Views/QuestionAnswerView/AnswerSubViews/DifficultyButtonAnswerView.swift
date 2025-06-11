//
//  DifficultyButtonView.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 09.06.25.
//

import SwiftUI

struct DifficultyButtonAnswerView: View {
    //    @EnvironmentObject private var studySessionViewModel: StudySessionViewModel
    
    let difficulty: CardDifficulty
    let action: () -> Void
    
    @State private var isPressed = false
    
    var body: some View {
        
        Button(action: action) {
            VStack(spacing: 6) {
                Image(systemName: difficulty.icon)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(difficulty.color)
                
                Text(difficulty.displayName)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(difficulty.color)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .padding(.horizontal, 8)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(difficulty.color.opacity(isPressed ? 0.2 : 0.1))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(difficulty.color.opacity(0.3), lineWidth: 1)
                    )
            )
            .scaleEffect(isPressed ? 0.95 : 1.0)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

