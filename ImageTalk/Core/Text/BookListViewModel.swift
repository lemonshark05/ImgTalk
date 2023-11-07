//
//  BookListViewModel.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/11/6.
//

import Foundation
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
        guard let currentUserId = Auth.auth().currentUser?.uid else {
            print("Current user is not authenticated")
            return
        }

        listenerRegistration = db.collection("books")
            .whereField("memberIds", arrayContains: currentUserId)
            .addSnapshotListener { [weak self] (querySnapshot, error) in
                if let error = error {
                    print("Error getting books: \(error)")
                    self?.books = []
                    return
                }
                
                guard let documents = querySnapshot?.documents else {
                    print("No documents found in 'books'")
                    self?.books = []
                    return
                }
                
                self?.books = documents.compactMap { document in
                    try? document.data(as: Book.self)
                }
            }
    }

    func addBook(title: String) {
        guard let currentUserId = Auth.auth().currentUser?.uid else {
            print("Current user is not authenticated")
            return
        }
        
        let newBook = Book(
            id: UUID().uuidString,
            title: title,
            author: currentUserId,
            wordCardIds: [],
            memberIds: [currentUserId]
        )
        
        do {
            try db.collection("books").document(newBook.id).setData(from: newBook)
        } catch {
            print("Error adding book: \(error)")
        }
    }

    func deleteBook(at offsets: IndexSet) {
        offsets.forEach { index in
            let bookId = books[index].id
            db.collection("books").document(bookId).delete() { error in
                if let error = error {
                    print("Error deleting book: \(error)")
                }
            }
        }
    }

    deinit {
        listenerRegistration?.remove()
    }
}
