//
//  view.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 06.06.25.
//

import SwiftUI

extension View {

  func toastView(toast: Binding<Toast?>) -> some View {
    self.modifier(ToastModifier(toast: toast))
  }
}
