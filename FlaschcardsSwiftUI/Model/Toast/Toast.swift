//
//  Toast.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 06.06.25.
//
import SwiftUI

// MARK: - Обновленная структура Toast
struct Toast: Equatable {
    let style: ToastStyle
    let message: String
    var duration: Double = 2.0
    let width: CGFloat?
    
    init(style: ToastStyle, message: String, duration: Double = 2.0, width: CGFloat? = nil) {
        self.style = style
        self.message = message
        self.duration = duration
        self.width = width
    }
}
