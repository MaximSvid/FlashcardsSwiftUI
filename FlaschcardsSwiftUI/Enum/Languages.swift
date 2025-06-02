//
//  Languages.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 08.05.25.
//

enum Language: String, CaseIterable, Identifiable {
    case english = "English"
    case russian = "Russian"
    
    var id: Self { self }
    
    var imageName: String {
        switch self {
        case .english:
            return "flag.us.fill"
        case .russian:
            return "flag.ru.fill"
        }
    }
}
