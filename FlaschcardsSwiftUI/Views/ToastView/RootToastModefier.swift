//
//  RootToastModefier.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 06.06.25.
//
import SwiftUI

// MARK: - Root Toast Modifier (применяется к корневому view)
struct RootToastModifier: ViewModifier {
    @StateObject private var toastManager = ToastManager.shared
    @State private var workItem: DispatchWorkItem?
    
    func body(content: Content) -> some View {
        content
            .overlay(alignment: .top) {
                if let toast = toastManager.toast {
                    ToastView(
                        style: toast.style,
                        message: toast.message,
                        width: toast.width
                    ) {
                        dismissToast()
                    }
//                    .padding(.top, 8) // Отступ от верха экрана
                    .transition(.asymmetric(
                        insertion: .move(edge: .top).combined(with: .opacity),
                        removal: .move(edge: .top).combined(with: .opacity)
                    ))
                    .zIndex(1000) // Высокий z-index для отображения поверх всего
                }
            }
            .animation(.spring(response: 0.6, dampingFraction: 0.8), value: toastManager.toast)
            .onChange(of: toastManager.toast) { oldValue, newValue in
                if newValue != nil {
                    showToast()
                }
            }
    }
    
    private func showToast() {
        guard let toast = toastManager.toast else { return }
        
        // Тактильная обратная связь
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        
        if toast.duration > 0 {
            workItem?.cancel()
            
            let task = DispatchWorkItem {
                dismissToast()
            }
            
            workItem = task
            DispatchQueue.main.asyncAfter(deadline: .now() + toast.duration, execute: task)
        }
    }
    
    private func dismissToast() {
        toastManager.dismiss()
        workItem?.cancel()
        workItem = nil
    }
}
