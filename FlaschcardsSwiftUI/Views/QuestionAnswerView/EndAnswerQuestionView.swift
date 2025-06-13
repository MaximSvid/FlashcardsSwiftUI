//
//  EndAnswerQuestionView.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 13.06.25.
//

import SwiftUI

struct EndAnswerQuestionView: View {
    @EnvironmentObject private var folderViewModel: FolderViewModel
    var selectedFolder: Folder?
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
//                    Text("You are folder: \(folderViewModel.selectedFolder) gelernt congradulation")
                    
//                    //easy
//                    EndButton(
//                        difficulty: .easy,
//                        count: <#T##Int#>,
//                        action: <#T##() -> Void#>
//                    )
//                    
//                    //normal
//                    EndButton(
//                        difficulty: <#T##CardDifficulty#>,
//                        count: <#T##Int#>,
//                        action: <#T##() -> Void#>
//                    )
//                    
//                    //hard
//                    EndButton(
//                        difficulty: <#T##CardDifficulty#>,
//                        count: <#T##Int#>,
//                        action: <#T##() -> Void#>
//                    )
//                    
//                    //reapetAll
//                    EndButton(
//                        difficulty: <#T##CardDifficulty#>,
//                        count: <#T##Int#>,
//                        action: <#T##() -> Void#>
//                    )
//                    
//                    //next Folder
//                    EndButton(
//                        difficulty: <#T##CardDifficulty#>,
//                        count: <#T##Int#>,
//                        action: <#T##() -> Void#>
//                    )
                }
                .navigationTitle("Folder \(selectedFolder?.name ?? "") end...")
                .padding()
                .frame(maxWidth: .infinity, maxHeight: geometry.size.height)
            }
        }
    }
}

#Preview {
    EndAnswerQuestionView()
}
