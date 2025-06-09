//
//  StudySessionView.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 09.06.25.
//

import SwiftUI

struct StudySessionView: View {
    @EnvironmentObject private var studySessionView: StudySessionViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            Group {
                if studySessionView.showingAnswer {
                    AnswerView()
                        .environmentObject(studySessionView)
                } else {
                    QuestionView()
                        .environmentObject(studySessionView)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        studySessionView.endStudySession()
                        dismiss()
                    }) {
                        Text("Close")
                    }
                }
            }
        }
        .onDisappear {
            if !studySessionView.studySessionActive {
                dismiss()
            }
        }
    }
}

