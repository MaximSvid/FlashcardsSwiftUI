//
//  HomeView.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 30.04.25.
//

import SwiftUI

let emptyAction: () -> Void = {
    // Do nothing
    print("Empty action executed")
}

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                Divider()
               FlaschcardsInfo()
                Spacer()
//                ButtonStart()
                MainButton(action: emptyAction, title: "Start")
            }
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.blue.opacity(0.03))
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        //action
                    }) {
                        Image(systemName: "paintpalette")
                            .foregroundStyle(.gray)
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    NewDeckSheet()
//                    Button(action: {
//                        //action
//                        
//                    }) {
//                        Image(systemName: "folder")
//                            .foregroundStyle(.gray)
//                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        //action
                    }) {
                        Image(systemName: "chart.bar")
                            .foregroundStyle(.gray)
                    }
                }
            }
            .toolbarBackground(Color.white, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}

#Preview {
    HomeView()
}
