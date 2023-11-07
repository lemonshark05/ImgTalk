//
//  VocabularyBookView.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/11/6.
//

import SwiftUI

struct BookListView: View {
    @StateObject private var viewModel = BookListViewModel()
    @State private var showingAddBookView = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.books, id: \.id) { book in
                    NavigationLink(destination: BookView(viewModel: BookViewModel(book: book))) {
                        Text(book.title)
                    }
                }
                .onDelete(perform: viewModel.deleteBook)
            }
            .navigationBarTitle("Books")
            .navigationBarItems(trailing: Button(action: {
                self.showingAddBookView = true
            }) {
                Image(systemName: "plus")
            })
            .onAppear {
                viewModel.fetchBooks()
            }
            .sheet(isPresented: $showingAddBookView) {
                AddBookView(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    BookListView()
}
