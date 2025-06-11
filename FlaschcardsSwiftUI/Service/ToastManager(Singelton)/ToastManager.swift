//
//  ToastManager.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 06.06.25.
//
import SwiftUI
// MARK: - Toast Manager (Singleton для глобального управления)
class ToastManager: ObservableObject {
    @Published var toast: Toast? = nil
    
    static let shared = ToastManager()
    
    private init() {}
    
    func show(_ toast: Toast) {
        withAnimation(.spring()) {
            self.toast = toast
        }
    }
    
    func dismiss() {
        withAnimation(.spring()) {
            self.toast = nil
        }
    }
}
