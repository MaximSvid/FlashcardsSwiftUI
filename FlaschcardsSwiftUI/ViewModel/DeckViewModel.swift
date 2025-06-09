//
//  DeckViewModel.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 09.05.25.
//
import SwiftUI
import SwiftData
import Combine

class DeckViewModel: ObservableObject {
    @Published var newDeckSheetIsPresented: Bool = false
    @Published var selectedLanguage: Language = .english
    @Published var selectedSourceLanguage: Language = .russian
    
    @Published var showAlertDialogUpdateDeckNameHomeView: Bool = false
    @Published var showAlertDialogUpdateDeckNameDeckView: Bool = false
    
    @Published var showAlertDialogCreateNewDeck: Bool = false
    @Published var showAlertDialogDeleteDeck: Bool = false
    
    //Combine properties for real-time validation
    @Published var isDuplicatePair: Bool = false
    @Published var isValidating: Bool = false
    @Published var errorMessage: String = ""
    
    @Published var toast: Toast? = nil
    
    @Published var selectedDeck: Deck?
    
    private let deckRepository: DeckRepository
    private var cancellables = Set<AnyCancellable>()
    private var modelContext: ModelContext?
    
    init(deckRepository: DeckRepository = DeckRepositoryImplementation()) {
        self.deckRepository = deckRepository
        setupCombineValidation()
    }
    
    // MARK: - Combine Setup
        private func setupCombineValidation() {
            // Combine selectedLanguage and selectedSourceLanguage changes
            Publishers.CombineLatest($selectedLanguage, $selectedSourceLanguage)
                .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main) // Небольшая задержка для оптимизации
                .removeDuplicates { prev, curr in
                    prev.0 == curr.0 && prev.1 == curr.1
                }
                .sink { [weak self] targetLanguage, sourceLanguage in
                    self?.validateLanguagePair(target: targetLanguage, source: sourceLanguage)
                }
                .store(in: &cancellables)
        }
        
        // Set model context for validation
        func setModelContext(_ context: ModelContext) {
            self.modelContext = context
            // Trigger initial validation
            validateLanguagePair(target: selectedLanguage, source: selectedSourceLanguage)
        }
        
        // MARK: - Real-time Validation
        private func validateLanguagePair(target: Language, source: Language) {
            guard let context = modelContext else { return }
            
            isValidating = true
            
            // Perform validation on background queue
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                do {
                    let descriptor = FetchDescriptor<Deck>()
                    let existingDecks = try context.fetch(descriptor)
                    
                    let exists = existingDecks.contains { deck in
                        deck.targetLanguage == target && deck.sourceLanguage == source
                    }
                    
                    DispatchQueue.main.async {
                        self?.isDuplicatePair = exists
                        self?.isValidating = false
                    }
                } catch {
                    DispatchQueue.main.async {
                        self?.isDuplicatePair = false
                        self?.isValidating = false
                        print("Validation error: \(error)")
                    }
                }
            }
        }
        
        // MARK: - Computed Properties
        var canCreateDeck: Bool {
            !isDuplicatePair && !isValidating
        }
        
        var validationMessage: String {
            if isValidating {
                return "Checking availability..."
            } else if isDuplicatePair {
                return "This language pair already exists"
            } else {
                return "Ready to create deck"
            }
        }
        
        var validationColor: Color {
            if isValidating {
                return .blue
            } else if isDuplicatePair {
                return .orange
            } else {
                return .green
            }
        }
        
        var validationIcon: String {
            if isValidating {
                return "clock.fill"
            } else if isDuplicatePair {
                return "exclamationmark.triangle.fill"
            } else {
                return "checkmark.circle.fill"
            }
        }
    
    func createNewDeck(context: ModelContext) {
        do {
            let _ = try deckRepository.createDeck(
                targetLanguage: selectedLanguage,
                sourceLanguage: selectedSourceLanguage,
                context: context
            )
            print("Deck saved successfully!")
            selectedLanguage = .english
            selectedSourceLanguage = .russian
            
            ToastManager.shared.show(
                Toast(style: .success, message: "Deck created successfully", width: .infinity)
            )
        } catch {
            ToastManager.shared.show(
                Toast(style: .error, message: "Failed to create deck", width: .infinity)
            )
            print("Faield to save context: \(error)")
        }
    }
    
    func deleteDeck(context: ModelContext, deck: Deck) {
        do {
            try deckRepository.deleteDeck(deck, context: context)
            ToastManager.shared.show(
                Toast(style: .info, message: "Deck deleted successfully", width: .infinity)
            )
            print("Deck deleted successfully!")
        } catch {
            ToastManager.shared.show(
                Toast(style: .error, message: "Failed to delete deck", width: .infinity)
            )
            print("Error deleting deck: \(error)")
        }
    }
}
