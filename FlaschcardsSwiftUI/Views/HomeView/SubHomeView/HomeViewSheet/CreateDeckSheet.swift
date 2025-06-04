//
//  CreateDeckSheet.swift
//  FlaschcardsSwiftUI
//
//  Created by Maxim Svidrak on 08.05.25.
//

import SwiftUI


struct CreateDeckSheet: View {
    @EnvironmentObject private var deckViewModel: DeckViewModel
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                // Header
                VStack(spacing: 8) {
                    Image(systemName: "plus.rectangle.on.folder")
                        .font(.system(size: 40))
                        .foregroundColor(.blue.opacity(0.7))
                    
                    Text("Create New Deck")
                        .font(.title2.bold())
                        .foregroundColor(.primary)
                }
                .padding(.top, 20)
                
                // Language Selection Section
                VStack(spacing: 20) {
                    // Native Language
                    LanguageSelectionCard(
                        title: "Your Native Language",
                        subtitle: "Language you know well",
                        selectedLanguage: $deckViewModel.selectedSourceLanguage,
                        icon: "house.fill"
                    )
                    .padding(.bottom, 30)
                    
                    
                    // Target Language
                    LanguageSelectionCard(
                        title: "Target Language",
                        subtitle: "Language you want to learn",
                        selectedLanguage: $deckViewModel.selectedLanguage,
                        icon: "target"
                    )
                }
                .padding(.horizontal)
                
                Spacer()
                
                Text("данная пара уже существует")
                // Create Button
                Button(action: {
                    deckViewModel.createNewDeck(context: modelContext)
                    dismiss()
                }) {
                    HStack {
                        Text("Create Deck")
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
        }
    }
}

struct LanguageSelectionCard: View {
    let title: String
    let subtitle: String
    @Binding var selectedLanguage: Language
    let icon: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.blue)
                    .font(.title3)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text(subtitle)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
            }
            
            // Language Picker
            Menu {
                Picker("Select Language", selection: $selectedLanguage) {
                    ForEach(Language.allCases) { language in
                        HStack {
                            Text("\(language.imageName) - \(language.displayName)")
                        }
                        .tag(language)
                    }
                }
            } label: {
                HStack {
                    Text(selectedLanguage.imageName)
                        .font(.title2)
                    
                    Text(selectedLanguage.displayName)
                        .font(.body)
                        .foregroundColor(.primary)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.down")
                        .foregroundColor(.secondary)
                        .font(.caption)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

