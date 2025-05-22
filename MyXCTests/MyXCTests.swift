//
//  MyXCTests.swift
//  MyXCTests
//
//  Created by Maxim Svidrak on 22.05.25.
//

import XCTest
@testable import FlaschcardsSwiftUI
import SwiftData

final class MyXCTests: XCTestCase {
    var deckViewModel: DeckViewModel!
    var mockDeckRepository: MockDeckRepository!
    var modelContext: ModelContext!
    
    override func setUp() {
        super.setUp()
        
        mockDeckRepository = MockDeckRepository()
        deckViewModel = DeckViewModel(deckRepository: mockDeckRepository)
        
        //Einstellungen für tests in-memory ModelContext
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: Deck.self, configurations: config)
        modelContext = ModelContext(container)
    }

    override func tearDown() {
        deckViewModel = nil
        mockDeckRepository = nil
        modelContext = nil
        super.tearDown()
    }
    
    func testCreateNewDeckSuccess() {
        deckViewModel.deckName = "TestDeck"
        deckViewModel.deckDescription = "TestDescription"
        
        //act
        deckViewModel.createNewDeck(context: modelContext)
        
        //Assert
        XCTAssertEqual(mockDeckRepository.createDeck?.title, "TestDeck")
        XCTAssertEqual(mockDeckRepository.createDeck?.deckDescription, "TestDescription")
    }
    
    func testUpdateDeckNameSuccess() {
        let deck = Deck(id: UUID(), title: "Max", deckDescription: nil, folders: [], createdAt: Date())
        deckViewModel.selectedDeck = deck
        deckViewModel.deckName = "New Name"
        
        //Act
        deckViewModel.updateDeckName(context: modelContext, deck: deck, newName: "New Name")
        
        //Assert
        XCTAssertEqual(mockDeckRepository.updateDeck, deck)
        XCTAssertEqual(mockDeckRepository.updatedDeckName, "New Name")
    }
    
    func testDeleteDeckSuccess() {
        let deck = Deck(id: UUID(), title: "Max", deckDescription: nil, folders: [], createdAt: Date())
        deckViewModel.selectedDeck = deck
        
        deckViewModel.deleteDeck(context: modelContext, deck: deck)
        
        XCTAssertEqual(mockDeckRepository.deleteDeck, deck)
    }

}
