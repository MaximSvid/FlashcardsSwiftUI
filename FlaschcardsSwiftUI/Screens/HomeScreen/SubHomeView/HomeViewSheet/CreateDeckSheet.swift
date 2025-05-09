//
//  CreateDeckSheet.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 08.05.25.
//

import SwiftUI




struct CreateDeckSheet: View {
    @EnvironmentObject private var deckViewModel: DeckViewModel
    var body: some View {
        VStack {
            Text("Create a new deck")
                .font(.headline)
                .padding()

            CustomTextField(placeholder: "Enter a deck name", text: $deckViewModel.deckName)
                .padding(.bottom)
            
            MainButton(action: {}, title: "Create new deck")
                .padding(.top)
            
        }
    }
}

#Preview {
    CreateDeckSheet()
}
