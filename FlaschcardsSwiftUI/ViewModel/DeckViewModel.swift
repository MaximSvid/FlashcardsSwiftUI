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
    //для сохранения состояния в выбранного языка после запуска приложения в userDefault
    @Published var selectedLanguage: Language = .english {
        didSet {
            UserDefaults.standard.set(selectedLanguage.rawValue, forKey: "selectedLanguage")
        }
    }
    @Published var selectedSourceLanguage: Language = .russian {
        didSet {
            UserDefaults.standard.set(selectedSourceLanguage.rawValue, forKey: "selectedSourceLanguage")
        }
    }
    
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
        loadPresistedLanguages()
        setupCombineValidation()
    }
    
    //MARK: Presistent Storage Methods
    //при запуске приложения инициализируется язык выбранный пользователем
    private func loadPresistedLanguages() {
        if let savedLanguageRaw = UserDefaults.standard.string(forKey: "selectedLanguage"),
           let savedLanguage = Language(rawValue: savedLanguageRaw) {
            selectedLanguage = savedLanguage
        }
        
        if let savedSourceLanguageRaw = UserDefaults.standard.string(forKey: "selectedSourceLanguage"),
           let savedSourceLanguage = Language(rawValue: savedSourceLanguageRaw) {
            selectedSourceLanguage = savedSourceLanguage
        }
    }
    
    // MARK: - Business Logic moved from HomeView
    
    /// Updates selected deck based on selected language
    func updateSelectedDeck(from decks: [Deck]) {
        selectedDeck = decks.first { $0.targetLanguage == selectedLanguage }
    }
    
    /// Checks if there are available folders with flashcards
    func hasAvailableFolders() -> Bool {
        return !(selectedDeck?.folders.isEmpty ?? true)
    }
    
    /// Creates default deck for create folder sheet
    func createDefaultDeck() -> Deck {
        return Deck(
            id: UUID(),
            folders: [],
            createdAt: Date(),
            targetLanguage: .english,
            sourceLanguage: .english
        )
    }
    
    /// Gets the deck for create folder operation
    func getDeckForCreateFolder() -> Deck {
        return selectedDeck ?? createDefaultDeck()
    }
    
    /// Manually select a specific deck (useful for deck switching)
        func selectDeck(_ deck: Deck) {
            selectedDeck = deck
            selectedLanguage = deck.targetLanguage ?? .english
            selectedSourceLanguage = deck.sourceLanguage ?? .russian
        }

    //-------------------------
    
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
    
    //теперь при создании выбирается сразу созданная папка
    func createNewDeck(context: ModelContext) -> Deck? {
        do {
            let newDeck = try deckRepository.createDeck(
                targetLanguage: selectedLanguage,
                sourceLanguage: selectedSourceLanguage,
                context: context
            )
            print("Deck saved successfully!")
            selectDeck(newDeck)
//            selectedLanguage = newDeck.targetLanguage ?? .english
//            selectedSourceLanguage = newDeck.sourceLanguage ?? .russian
            
            ToastManager.shared.show(
                Toast(style: .success, message: "Deck created successfully", width: .infinity)
            )
            return newDeck
        } catch {
            ToastManager.shared.show(
                Toast(style: .error, message: "Failed to create deck", width: .infinity)
            )
            print("Faield to save context: \(error)")
            return nil
        }
    }
    
    func deleteDeck(context: ModelContext, deck: Deck) {
        do {
            try deckRepository.deleteDeck(deck, context: context)
            
            if selectedDeck?.id == deck.id {
                selectedDeck = nil
                // Не сбрасываем языки, чтобы при следующем запуске попытаться найти колоду с этими языками
            }
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
