//
//  FlaschcardsInfo.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 07.05.25.
//

import SwiftUI

struct FlaschcardsInfo: View {
    var body: some View {
        HStack {
            VStack {
                Text ("1234")
                    .foregroundStyle(.green)
                    .font(.headline)
                    .padding(.bottom)
                
                Text("Info")
                    .foregroundStyle(.green)
                    .font(.caption)
            }
            
            .frame(width: 110, height: 90)
            .overlay(
                RoundedRectangle(cornerRadius: 3)
                    .stroke(.gray, lineWidth: 1)
            )
            
            Spacer()
            
            VStack {
                Text ("1234")
                    .foregroundStyle(.blue)
                    .font(.headline)
                    .padding(.bottom)
                
                Text("Info")
                    .foregroundStyle(.blue)
                    .font(.caption)
            }
            
            .frame(width: 110, height: 90)
            .overlay(
                RoundedRectangle(cornerRadius: 3)
                    .stroke(.gray, lineWidth: 1)
            )
            
            Spacer()
            
            VStack {
                Text ("1234")
                    .foregroundStyle(.yellow)
                    .font(.headline)
                    .padding(.bottom)
                
                Text("Info")
                    .foregroundStyle(.yellow)
                    .font(.caption)
            }
            
            .frame(width: 110, height: 90)
            .overlay(
                RoundedRectangle(cornerRadius: 3)
                    .stroke(.gray, lineWidth: 1)
            )
        }
        .padding(.top)
        .padding(.horizontal)
    }
}

#Preview {
    FlaschcardsInfo()
}
