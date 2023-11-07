//
//  BookViewModel.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/11/6.
//

import Foundation
import Firebase

class BookViewModel: ObservableObject {
    @Published var book: Book
    @Published var wordCards: [WordCard] = []
    private var db = Firestore.firestore()
    
    init(book: Book) {
        self.book = book
        fetchWordCards()
    }
    
    func fetchWordCards() {
        db.collection("books").document(book.id).collection("wordCards")
            .addSnapshotListener { [weak self] querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("No documents in 'wordCards'")
                    return
                }
                
                self?.wordCards = documents.compactMap { queryDocumentSnapshot -> WordCard? in
                    try? queryDocumentSnapshot.data(as: WordCard.self)
                }
            }
    }
    
    func addWordCard(wordCard: WordCard) {
        do {
            let _ = try db.collection("books").document(book.id).collection("wordCards").addDocument(from: wordCard)
        } catch {
            print(error)
        }
    }
    
    func deleteWordCard(at indexSet: IndexSet) {
        // Implement deletion logic
    }
}

