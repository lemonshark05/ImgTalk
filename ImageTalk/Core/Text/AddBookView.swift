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
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Book Details")) {
                    TextField("Title", text: $title)
                }
                
                Button("Add Book") {
                    // Create a new book object
                    viewModel.addBook(title: title)
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

