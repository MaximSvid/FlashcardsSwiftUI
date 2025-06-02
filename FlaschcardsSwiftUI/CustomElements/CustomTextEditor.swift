//
//  CustomTextField2.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 23.05.25.
//

import SwiftUI

struct CustomTextEditor: View {
    let placeholder: String
    @Binding var text: String
    @FocusState var isFocesed: Bool
    
    var body: some View {
        TextEditor(text: $text)
//            .padding()
            .foregroundStyle(.black)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(isFocesed ? .green : .black, lineWidth: 1)
            )
            .frame(maxWidth: .infinity, minHeight: 90)
            .overlay(
                Group {
                    if text.isEmpty && !isFocesed {
                        Text(placeholder)
                            .foregroundStyle(.gray)
                    }
                },
                alignment: .topLeading
            )
    }
}
