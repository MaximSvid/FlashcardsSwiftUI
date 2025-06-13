//
//  EndAnswerQuestionView.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 13.06.25.
//

import SwiftUI

struct EndAnswerQuestionView: View {
    @EnvironmentObject private var folderViewModel: FolderViewModel
    @EnvironmentObject private var flashcardViewModel: FlashcardViewModel
    var selectedFolder: Folder?
    @EnvironmentObject private var studySessionViewModel: StudySessionViewModel
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Spacer()
                    VStack {
                        Text("Study Results")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundStyle(.primary)
                            .padding(.bottom, 20)
                        
                        
                        //easy
                        EndButton(
                            difficulty: .easy,
                            count: flashcardViewModel.difficultyStats.easy,
                            action: {
                                studySessionViewModel.startStudySessionWithDifficulty(.easy)
                            }
                        )
                        
                        //normal
                        EndButton(
                            difficulty: .normal,
                            count: flashcardViewModel.difficultyStats.normal,
                            action: {
                                studySessionViewModel.startStudySessionWithDifficulty(.normal)
                            }
                        )
                        
                        //hard
                        EndButton(
                            difficulty: .hard,
                            count: flashcardViewModel.difficultyStats.hard,
                            action: {
                                studySessionViewModel.startStudySessionWithDifficulty(.hard)
                            }
                        )
                        
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
                        //                    Spacer()
                    }
                    //
                }
//                .navigationTitle("Folder \(selectedFolder?.name ?? "") end...")
                .padding()
                .frame(maxHeight: geometry.size.height)
                .frame(maxWidth: .infinity)
            }
        }
    }
}

