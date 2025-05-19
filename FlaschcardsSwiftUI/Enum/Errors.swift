//
//  Errors.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 19.05.25.
//

enum Errors: Error {
    case emptyTitle
    
    var message: String {
        switch self {
        case .emptyTitle:
            return "Deck title is empty"
        }
    }
    
}
