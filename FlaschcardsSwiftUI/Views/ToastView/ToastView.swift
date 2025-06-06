//
//  ToastView.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 06.06.25.
//

import SwiftUI

struct ToastView: View {
    var style: ToastStyle
    var message: String
    var width: CGFloat?
    var onCancelTapped: (() -> Void)
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Image(systemName: style.iconFileName)
                .foregroundColor(style.themeColor)
                .font(.system(size: 16, weight: .medium))
            
            Text(message)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.primary)
                .multilineTextAlignment(.leading)
                .lineLimit(3)
            
            Spacer(minLength: 10)
            
            Button {
                onCancelTapped()
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(.secondary)
                    .font(.system(size: 12, weight: .medium))
            }
        }
//        .padding([.top, .bottom, .leading, .trailing])
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .frame(maxWidth: width ?? .infinity)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.regularMaterial)
                .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(style.themeColor.opacity(0.3), lineWidth: 1)
        )
        .padding(.horizontal, 8)
        .onTapGesture {
            onCancelTapped()
        }
    }
}
