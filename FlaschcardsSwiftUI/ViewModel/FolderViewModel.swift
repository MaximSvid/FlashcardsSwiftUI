//
//  FolderViewModel.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 20.05.25.
//
import SwiftUI
import SwiftData

class FolderViewModel: ObservableObject {
    @Published var folderName: String = ""
    
    @Published var showAlertCreateNewFolder: Bool = false
    @Published var showAlertUpdateFolder: Bool = false
    @Published var showAlerDeleteFolder: Bool = false
    
    @Published var selectedFolder: Folder?
    @Published var selectedDeck: Deck?
    
    private let folderRepositry: FolderRepository
    
    init(folderRepository: FolderRepository = FolderRepositoryImplementation()) {
        self.folderRepositry = folderRepository
    }
    
    func createNewFolder(in deck: Deck, context: ModelContext) {
        
        do {
            _ = try folderRepositry.createFolder(name: folderName, in: deck, context: context)
            
            print("Folder \(folderName) created")
            folderName = ""
            showAlertCreateNewFolder = false
        } catch {
            print("Folder \(folderName) not created: \(error.localizedDescription)")
        }
    }
    
    func deleteFolder(context: ModelContext, folder: Folder) {
        do {
            try folderRepositry.deleteFolder(folder: folder, context: context)
            print( "Folder: \(folder.name) deleted")
        } catch {
            print("Error deleting folder: \(error.localizedDescription)")
        }
    }
    
    func updateFolderName(folder: Folder, newName: String, context: ModelContext) {
        do {
            try folderRepositry.updateFolder(folder: folder, newName: newName, context: context)
            print("Folder: \(folder.name) updated to \(newName)")
            folderName = ""
        } catch {
            print("Error updating folder name: \(error.localizedDescription)")
        }
    }
    var folders: [Folder] {
        return selectedDeck?.folders ?? []
    }
    func getNextFolder(after currentFolder: Folder) -> Folder? {
        let allFolders = folders
        guard let currentIndex = allFolders.firstIndex(where: {$0.id == currentFolder.id}) else {
            return nil
        }
        let nextIndex = currentIndex + 1
        
        for i in nextIndex..<allFolders.count {
            let folder = allFolders[i]
            if !folder.flashcards.isEmpty {
                return folder
            }
        }
        return nil
    }
}
