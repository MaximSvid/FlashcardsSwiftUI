//
//  CreateDeckSheet.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 08.05.25.
//

import SwiftUI

let emptyAction2: () -> Void = {
    // Do nothing
    print("Empty action executed")
}


struct CreateDeckSheet: View {
    @State private var isShowingSheet: Bool = false
    var body: some View {
        VStack {
//            TextField
            
            MainButton(action: emptyAction2, title: "Create new deck")
        }
    }
}

#Preview {
    CreateDeckSheet()
}
