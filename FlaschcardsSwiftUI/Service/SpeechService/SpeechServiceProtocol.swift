//
//  SpeechServiceProtocol.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 11.06.25.
//

protocol SpeechServiceProtocol {
    func speak(text: String, language: Language)
    func stopSpeaking()
}
