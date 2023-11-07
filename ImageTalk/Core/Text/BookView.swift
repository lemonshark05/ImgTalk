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
    @State private var showingAddWordCardView = false
    
    var body: some View {
        List {
            Section(header: Text("Word Cards")) {
                ForEach(viewModel.wordCards) { wordCard in
                    NavigationLink(destination: WordCardView(wordCard: wordCard, viewModel: viewModel)) {
                        VStack(alignment: .leading) {
                            Text(wordCard.word)
                                .font(.headline)
                            Image(systemName: wordCard.marked ? "star.fill" : "star")
                                .foregroundColor(wordCard.marked ? .yellow : .gray)
                                .onTapGesture {
                                    viewModel.toggleMarked(for: wordCard.id)
                                }
                        }
                    }
                }
                .onDelete(perform: viewModel.deleteWordCard)
            }
        }
        .navigationBarTitle(viewModel.book.title)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: AddWordCardView(viewModel: viewModel)) {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

#Preview {
    BookView(viewModel: BookViewModel(book: Book(id: "book1", title: "Sample Book", author: "hula", wordCardIds: [], memberIds: [])))
}
