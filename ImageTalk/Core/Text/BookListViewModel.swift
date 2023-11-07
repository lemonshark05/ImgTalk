//
//  BookListViewModel.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/11/6.
//

import Foundation
import Firebase

import Firebase
import FirebaseFirestore
import FirebaseAuth

class BookListViewModel: ObservableObject {
    @Published var books: [Book] = []
    private var db = Firestore.firestore()
    private var listenerRegistration: ListenerRegistration?

    init() {
        fetchBooks()
    }

    func fetchBooks() {
        listenerRegistration = db.collection("books")
            .whereField("author", isEqualTo: Auth.auth().currentUser?.uid ?? "")
            .addSnapshotListener { [weak self] (querySnapshot, error) in
                guard let self = self else { return }
                if let error = error {
                    print("Error getting books: \(error)")
                    self.books = []
                } else {
                    self.books = querySnapshot?.documents.compactMap { document -> Book? in
                        try? document.data(as: Book.self)
                    } ?? []
                }
            }
    }

    func addBook(book: Book) {
        do {
            let _ = try db.collection("books").addDocument(from: book)
        } catch let error {
            print("Error adding book: \(error)")
        }
    }

    func deleteBook(at offsets: IndexSet) {
        offsets.forEach { index in
            let bookId = books[index].id
            db.collection("books").document(bookId).delete() { error in
                if let error = error {
                    print("Error deleting book: \(error)")
                } else {
                }
            }
        }
    }
    
    func removeListener() {
        listenerRegistration?.remove()
    }
}

