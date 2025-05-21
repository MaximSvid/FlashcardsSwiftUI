//
//  FolderRepositoryImplementation.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 20.05.25.
//

import SwiftData
import SwiftUI

class FolderRepositoryImplementation: FolderRepository {
    func createFolder(name: String, in deck: Deck, context: ModelContext) throws -> Folder {
        guard !name.isEmpty else {
            throw Errors.emptyTitle
        }
        
        let newFolder = Folder(
            id: UUID(),
            name: name,
            createdAt: Date()
        )
        context.insert(newFolder)
        deck.folders.append(newFolder)
        
        try context.save()
        return newFolder
        
    }
    
    func updateFolder(folder: Folder, newName: String, context: ModelContext) throws {
        guard !newName.isEmpty else {
            throw Errors.emptyTitle
        }
        folder.name = newName
        try context.save()
    }
    
    func deleteFolder(folder: Folder, context: ModelContext) throws {
        context.delete(folder)
        try context.save()
    }
}
