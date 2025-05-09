//
//  CustomTextField.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 09.05.25.
//

import SwiftUI

struct CustomTextField: View {
    let placeholder: String
    @Binding var text: String
    @FocusState var isFocused: Bool
    
    var body: some View {
        TextField(placeholder, text: $text)
            .padding()
            .foregroundStyle(.green.opacity(0.7))
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(isFocused ? .black : .green.opacity(0.7), lineWidth: 1)
            )
            .focused($isFocused)
    }
}

