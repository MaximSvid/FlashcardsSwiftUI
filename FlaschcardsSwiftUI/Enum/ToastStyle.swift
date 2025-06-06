//
//  ToastStyle.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 06.06.25.
//

import SwiftUI

enum ToastStyle {
    case error, warning, success, info
    
    var themeColor: Color {
        switch self {
        case .error: return Color(.systemRed)
        case .warning: return Color(.systemOrange)
        case .info: return Color(.systemBlue)
        case .success: return Color(.systemGreen)
        }
    }
    
    var iconFileName: String {
        switch self {
        case .info: return "info.circle.fill"
        case .warning: return "exclamationmark.triangle.fill"
        case .success: return "checkmark.circle.fill"
        case .error: return "xmark.circle.fill"
        }
    }
}
