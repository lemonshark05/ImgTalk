//
//  AddBookView.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/11/6.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: BookListViewModel
    
    @State private var title: String = ""
    @State private var author: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Book Details")) {
                    TextField("Title", text: $title)
                    TextField("Author", text: $author)
                }
                
                Button("Add Book") {
                    // Create a new book object
                    let newBook = Book(id: UUID().uuidString, title: title, author: author, wordCardIds: [])
                    viewModel.addBook(book: newBook)
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .navigationBarTitle("Add Book", displayMode: .inline)
            .navigationBarItems(trailing: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

