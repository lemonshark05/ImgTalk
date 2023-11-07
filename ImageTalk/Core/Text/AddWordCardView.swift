//
//  AddWordCardView.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/11/6.
//

import SwiftUI

struct AddWordCardView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var word = ""
    @State private var explanation = ""
    @State private var synonyms = ""
    @State private var examples = ""
    
    var viewModel: BookViewModel
    
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
                presentationMode.wrappedValue.dismiss()
            }, trailing: Button("Save") {
                let newWordCard = WordCard(
                    id: UUID().uuidString, // It's safe to assign a UUID here as we don't need to use Firestore's document IDs
                    word: word,
                    explanation: explanation,
                    synonyms: synonyms.components(separatedBy: ";").filter { !$0.isEmpty },
                    examples: examples.components(separatedBy: ";").filter { !$0.isEmpty },
                    bookIds: [viewModel.book.id],
                    wrongTimes: 0,
                    marked: false
                )
                viewModel.addWordCard(wordCard: newWordCard)
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}
