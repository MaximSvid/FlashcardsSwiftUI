//
//  ButtonStart.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 07.05.25.
//

import SwiftUI

struct ButtonStart: View {
    var body: some View {
        VStack {
            Button(action: {
                
            }) {
                Text("Start")
                    .foregroundStyle(.white)
                    .font(.headline)
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.blue.opacity(0.7))
                    )
            }
            .padding(.bottom)
            .padding(.horizontal)
            
        }
    }
}

#Preview {
    ButtonStart()
}
