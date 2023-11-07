//
//  VocabularyBookView.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/11/6.
//

import SwiftUI

struct BookListView: View {
    @StateObject private var viewModel = BookListViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.books, id: \.id) { book in
                    NavigationLink(destination: BookView(bookId: book.id)) {
                        Text(book.title)
                    }
                }
                .onDelete(perform: viewModel.deleteBook)
            }
            .navigationBarTitle("Books")
            .navigationBarItems(trailing: Button(action: {
                viewModel.addBook()
            }) {
                Image(systemName: "plus")
            })
            .onAppear {
                viewModel.fetchBooks()
            }
        }
    }
}

#Preview {
    BookView()
}
