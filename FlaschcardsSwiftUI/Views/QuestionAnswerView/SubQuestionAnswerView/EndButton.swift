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
//    let isDisabled: Bool
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: difficulty.icon)
                    .font(.system(size: 24, weight: .medium))
                    .foregroundStyle(difficulty.color)
                
                Text(difficulty.displayName)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(difficulty.color)
                
                Text("\(count)")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.white)
                    .background(difficulty.color)
            }
            .frame(maxWidth: .infinity)
            .padding()
//            .background(
//                RoundedRectangle(cornerRadius: 12)
//            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
//                    .stroke((isDisabled ? Color.gray : difficulty.color).opacity(0.3), lineWidth: 1)
            )
        }
        .padding([.top, .bottom], 15)
        .buttonStyle(PlainButtonStyle())
    }
}

