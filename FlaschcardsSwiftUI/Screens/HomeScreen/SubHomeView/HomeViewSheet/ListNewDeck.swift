//
//  ListNewDeck.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 07.05.25.
//

import SwiftUI

struct ListNewDeck: View {
    var body: some View {
        HStack {
            Text("Deck 1")
                .font(.headline)
            Spacer()
            
            Image(systemName: "pencil")
                .font(.callout)
        }
    }
}

