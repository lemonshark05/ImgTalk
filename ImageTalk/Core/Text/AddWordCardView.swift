//
//  AddWordCardView.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/11/6.
//

import SwiftUI

struct AddWordCardView: View {
    @State private var word = ""
    @State private var explanation = ""
    @State private var synonyms = ""
    @State private var examples = ""
    
    var onSave: (WordCard) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Word")) {
                    TextField("Word", text: $word)
                }
                Section(header: Text("Explanation")) {
                    TextField("Explanation", text: $explanation)
                }
                Section(header: Text("Synonyms")) {
                    TextField("Synonyms", text: $synonyms)
                }
                Section(header: Text("Examples")) {
                    TextField("Examples", text: $examples)
                }
            }
            .navigationBarTitle("New Word", displayMode: .inline)
            .navigationBarItems(leading: Button("Cancel") {
                // Code to dismiss the view
            }, trailing: Button("Save") {
                let newWordCard = WordCard(
                    id: UUID().uuidString,
                    word: word,
                    explanation: explanation,
                    synonyms: synonyms.components(separatedBy: ";").filter { !$0.isEmpty },
                    examples: examples.components(separatedBy: ";").filter { !$0.isEmpty },
                    bookIds: []
                )
                onSave(newWordCard)
            })
        }
    }
}

#Preview {
    AddWordCardView { wordCard in
        print("Saved WordCard: \(wordCard)")
    }
}
