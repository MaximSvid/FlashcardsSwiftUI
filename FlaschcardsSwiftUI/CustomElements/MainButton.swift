//
//  MainButton.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 08.05.25.
//

import SwiftUI

struct MainButton: View {
    var action: () -> Void
    var title: String
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .frame(maxWidth: .infinity, maxHeight: 50)
                .foregroundStyle(.white)
                .background(.blue)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding([.trailing, .leading])
        }
    }
}

