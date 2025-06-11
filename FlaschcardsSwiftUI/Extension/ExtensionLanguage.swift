//
//  ExtensionLanguage.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 11.06.25.
//

extension Language {
    var speechLanguageCode: String {
        switch self {
        case .english:
            return "en-US"
        case .german:
            return "de-DE"
        case .spanish:
            return "es-ES"
        case .french:
            return "fr-FR"
        case .italian:
            return "it-IT"
        case .russian:
            return "ru-RU"
        case .chinese:
            return "zh-CN"
        case .japanese:
            return "ja-JP"
        }
    }
}
