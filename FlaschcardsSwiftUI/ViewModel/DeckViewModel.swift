//
//  DeckViewModel.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 09.05.25.
//
import SwiftUI

class DeckViewModel: ObservableObject {
    @Published var newDeckSheetIsPresented: Bool = false
    @Published var deckName: String = ""
    
}
