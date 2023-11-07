//
//  BookView.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/11/6.
//

import SwiftUI

import SwiftUI

struct BookView: View {
    @StateObject var viewModel: BookViewModel
    
    var body: some View {
        List {
            Section(header: Text("Word Cards")) {
                ForEach(viewModel.wordCards) { wordCard in
                    VStack(alignment: .leading) {
                        Text(wordCard.word)
                            .font(.headline)
                        Text(wordCard.explanation)
                            .font(.subheadline)
                    }
                }
                .onDelete(perform: viewModel.deleteWordCard)
            }
        }
        .navigationBarTitle(viewModel.book.title)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    // Add WordCard action
                }) {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

#Preview {
    BookView(viewModel: BookViewModel(book: Book(id: "book1", title: "Sample Book", author: "hula", wordCardIds: [])))
}
