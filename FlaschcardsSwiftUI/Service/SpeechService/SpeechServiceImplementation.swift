//
//  SpeechServiceImplementation.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 11.06.25.
//
import AVFoundation
class SpeechServiceImplementation: SpeechServiceProtocol {
    private let synthesizer = AVSpeechSynthesizer()
    
    func speak(text: String, language: Language) {
        if synthesizer.isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
        }
        
        let utterance = AVSpeechUtterance(string: text) // erstellen ein Objeckt für sprahe
        utterance.voice = AVSpeechSynthesisVoice(language: language.speechLanguageCode) // sprache
        utterance.rate = 0.5 // geschwindigkeit von spracke - 0.5 normal
        utterance.pitchMultiplier = 1.0 // ton
        utterance.volume = 1.0 //laute stärke
        
        synthesizer.speak(utterance)
    }
    
    func stopSpeaking() {
        synthesizer.stopSpeaking(at: .immediate)
    }
    
    
}
