//
//  ButtonEllipsis.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 16.06.25.
//

import SwiftUI

struct ButtonEllipsis: View {
    @State private var isExpanded = true
    @Environment(\.colorScheme) private var colorScheme
    var action: () -> Void = {}
    var body: some View {
        Button(action: action) {
            Image(systemName: "ellipsis")
                .font(.title3)
                .foregroundStyle(isExpanded ? colorScheme.currentColor : Color.primary)
                .frame(width: 45, height: 45)
                .background(
                    ZStack{
                        Rectangle()
                            .fill(.ultraThinMaterial)
                        
                        Rectangle()
                            .fill(Color.primary.opacity(isExpanded ? 1 : 0.03))
                    }
                        .clipShape(.circle)
                )
        }
    }
}

extension ColorScheme {
    var currentColor: Color {
        switch self {
        case .light:
            return .white
        case .dark:
            return .black
        default: return .clear
        }
    }
}

#Preview {
    ButtonEllipsis()
}
