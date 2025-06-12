//
//  CardDifficulty.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 09.06.25.
//

import SwiftUI

enum CardDifficulty: String, CaseIterable, Codable {
    case easy = "easy"
    case normal = "normal"
    case hard = "hard"
    
    var displayName: String {
        switch self {
        case .easy:
            return "Easy"
        case .normal:
            return "Normal"
        case .hard:
            return "Hard"
        }
    }
    var color: Color {
        switch self {
        case .easy:
            return .green
        case .normal:
            return .yellow
        case .hard:
            return .red
        }
    }
    
    var icon: String {
        switch self {
        case .easy: return "hand.thumbsup.fill"
        case .normal: return "hand.point.up.fill"
        case .hard: return "hand.thumbsdown.fill"
        }
    }
}
