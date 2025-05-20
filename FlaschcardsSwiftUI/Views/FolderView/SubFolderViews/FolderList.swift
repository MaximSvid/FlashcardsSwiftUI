//
//  FolderList.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 20.05.25.
//

import SwiftUI
import SwiftData

struct FolderList: View {
    @EnvironmentObject private var folderViewModel: FolderViewModel
    @Environment(\.modelContext) private var modelContext
    @Query private var folders: [Folder]
    
    var body: some View {
        List {
            ForEach(folders) { folder in
                Text(folder.name)
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    FolderList()
}
