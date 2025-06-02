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
            .foregroundStyle(.black)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(isFocused ? .green : .black, lineWidth: 1)
            )
            .focused($isFocused)
            .padding()
    }
}

