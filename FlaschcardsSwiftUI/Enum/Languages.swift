//
//  Languages.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 08.05.25.
//

enum Language: String, Codable, CaseIterable, Identifiable {
    case english = "English"
    case german = "German"
//    case russian = "Russian"
    
//    var id: Self { self }
    var id: String { rawValue }
    
    var imageName: String {
        switch self {
        case .english:
            return "flag.us.fill"
        case .german:
            return "flag.de.fill"
        }
    }
}
