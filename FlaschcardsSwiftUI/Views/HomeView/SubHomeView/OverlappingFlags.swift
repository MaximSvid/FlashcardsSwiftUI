//
//  OverlappingFlags.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 06.06.25.
//
import SwiftUI

// MARK: - Компонент для отображения наложенных флагов
struct OverlappingFlags: View {
    let nativeLanguage: Language
    let targetLanguage: Language
    let size: CGFloat
    
    init(native: Language, target: Language, size: CGFloat = 24) {
        self.nativeLanguage = native
        self.targetLanguage = target
        self.size = size
    }
    
    var body: some View {
        ZStack {
            // Задний флаг (родной язык) - немного смещен
            Text(nativeLanguage.imageName)
                .font(.system(size: size))
                .offset(x: -size * 0.35, y: size * 0.35)
//                .opacity(0.7)
                .scaleEffect(0.9)
            
            // Передний флаг (изучаемый язык)
            Text(targetLanguage.imageName)
                .font(.system(size: size))
                .offset(x: size * 0.1, y: -size * 0.1)
//                .shadow(color: .black.opacity(0.2), radius: 2, x: 1, y: 1)
        }
        .frame(width: size * 1.4, height: size * 1.4)
    }
}
