//
//  EditCardsView.swift
//  Flashzilla
//
//  Created by Uriel Ortega on 14/07/23.
//

import SwiftUI

struct EditCardsView: View {
    @Environment(\.dismiss) var dismiss
        
    @State private var cards = [Card]()
    @State private var newPrompt = ""
    @State private var newAnswer = ""
    
    let saveKey = "SavedCards"

    var body: some View {
        NavigationStack {
            List {
                Section("Add new card") {
                    TextField("Prompt", text: $newPrompt)
                    TextField("Answer", text: $newAnswer)
                    Button("Add Card", action: addCard)
                        .disabled(newPrompt.isEmpty || newAnswer.isEmpty)
                }
                
                Section {
                    ForEach(0..<cards.count, id: \.self) { index in
                        VStack {
                            Text(cards[index].prompt)
                                .font(.headline)
                            Text(cards[index].answer)
                                .foregroundColor(.secondary)
                        }
                    }
                    .onDelete(perform: removeCards)
                }
            }
            .navigationTitle("Edit Cards")
            .toolbar {
                Button("Done") { dismiss() }
            }
            .listStyle(.grouped)
            .onAppear(perform: loadData)
        }
    }
    
    func addCard() {
        let trimmedPrompt = newPrompt.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespaces)
        
        guard !trimmedPrompt.isEmpty && !trimmedAnswer.isEmpty else { return }
        
        let card = Card(prompt: trimmedPrompt, answer: trimmedAnswer)
        cards.insert(card, at: 0)
        saveData()
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                cards = decoded
                return
            }
        }
        
        cards = [] // No saved data.
    }
    
    func saveData() {
        if let encoded = try? JSONEncoder().encode(cards) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    
    func removeCards(at offsets: IndexSet) {
        cards.remove(atOffsets: offsets)
        saveData()
    }
}

struct EditCardsView_Previews: PreviewProvider {
    static var previews: some View {
        EditCardsView()
    }
}
