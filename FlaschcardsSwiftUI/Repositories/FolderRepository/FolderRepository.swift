//
//  FolderReposiroty.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 20.05.25.
//

import SwiftData

protocol FolderRepository {
    func createFolder(name: String, in deck: Deck, context: ModelContext) throws -> Folder
    func updateFolder(folder: Folder, newName: String, context: ModelContext) throws
    func deleteFolder(folder: Folder, context: ModelContext) throws
}
