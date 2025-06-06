//
//  view.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 06.06.25.
//

import SwiftUI

// MARK: - View Extension для удобного использования
extension View {
    func withRootToast() -> some View {
        self.modifier(RootToastModifier())
    }
    
    // Метод для показа toast из любого места в приложении
    func showToast(_ toast: Toast) {
        ToastManager.shared.show(toast)
    }
}
