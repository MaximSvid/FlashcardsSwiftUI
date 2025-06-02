//
//  CreateDeckSheet.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 08.05.25.
//

import SwiftUI

struct CreateDeckSheet: View {
    @EnvironmentObject private var deckViewModel: DeckViewModel
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss // um CreateDeckSheet zu verlassen
    
    var body: some View {
        VStack {
            Text("Create a new deck")
                .font(.title3.bold())
                .padding()

            CustomTextField(placeholder: "Enter a deck name", text: $deckViewModel.deckName)
                .padding(.bottom)
            
            MainButton(action: {
                deckViewModel.createNewDeck(context: modelContext)
                dismiss()
            }, title: "Create new deck")
                .padding(.top)
        }
    }
}

#Preview {
    CreateDeckSheet()
}
