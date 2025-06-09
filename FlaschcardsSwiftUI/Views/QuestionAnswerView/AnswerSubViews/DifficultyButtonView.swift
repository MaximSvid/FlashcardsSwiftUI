//
//  DifficultyButtonView.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 09.06.25.
//

import SwiftUI

struct DifficultyButtonView: View {
    @EnvironmentObject private var studySessionViewModel: StudySessionViewModel
    
    var body: some View {
        HStack {
            Button(action: {
                studySessionViewModel.nextCard()
            }) {
                HStack(spacing: 8) {
                    Image(systemName: CardDifficulty.easy.icon)
                        .foregroundStyle(CardDifficulty.easy.color)
                    Text(CardDifficulty.easy.displayName)
                        .foregroundStyle(CardDifficulty.easy.color)
                }
            }
            
            Button(action: {
                studySessionViewModel.nextCard()
            }) {
                HStack(spacing: 8) {
                    Image(systemName: CardDifficulty.normal.icon)
                        .foregroundStyle(CardDifficulty.normal.color)
                    Text(CardDifficulty.normal.displayName)
                        .foregroundStyle(CardDifficulty.normal.color)
                    
                }
            }
            
            Button(action: {
                studySessionViewModel.nextCard()
            }) {
                HStack(spacing: 8) {
                    Image(systemName: CardDifficulty.hard.icon)
                        .foregroundStyle(CardDifficulty.hard.color)
                    Text(CardDifficulty.hard.displayName)
                        .foregroundStyle(CardDifficulty.hard.color)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(style: StrokeStyle(lineWidth: 1))
        )
        
    }
}

