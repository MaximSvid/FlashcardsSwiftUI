//
//  Languages.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 08.05.25.
//

enum Language: String, Codable, CaseIterable, Identifiable {
    case english = "English"
    case german = "German"
    case spanish = "Spanish"
    case french = "French"
    case italian = "Italian"
    case russian = "Russian"
    case chinese = "Chinese"
    case japanese = "Japanese"
    
    var id: String { rawValue }
    
    var imageName: String {
        switch self {
        case .english:
            return "🇺🇸"
        case .german:
            return "🇩🇪"
        case .spanish:
            return "🇪🇸"
        case .french:
            return "🇫🇷"
        case .italian:
            return "🇮🇹"
        case .russian:
            return "🇷🇺"
        case .chinese:
            return "🇨🇳"
        case .japanese:
            return "🇯🇵"
        }
    }
    
    var displayName: String {
        rawValue
    }
}
