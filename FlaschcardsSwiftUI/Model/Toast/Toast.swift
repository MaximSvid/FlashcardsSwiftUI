//
//  Toast.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 06.06.25.
//
import SwiftUI

struct Toast: Equatable {
    let style: ToastStyle
    let message: String
    var duration: Double = 2
    let width: CGFloat?
    
    init(style: ToastStyle, message: String, width: CGFloat? = nil) {
        self.style = style
        self.message = message
        self.width = width
    }
}
