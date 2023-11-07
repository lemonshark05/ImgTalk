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
    private var listenerRegistration: ListenerRegistration?
    
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
                
                let fetchedWordCards: [WordCard] = documents.compactMap { queryDocumentSnapshot -> WordCard? in
                    try? queryDocumentSnapshot.data(as: WordCard.self)
                }
                
                self?.wordCards = fetchedWordCards.sorted {
                    if $0.marked == $1.marked {
                        return $0.wrongTimes > $1.wrongTimes
                    }
                    return $0.marked && !$1.marked
                }
            }
    }
    
    func toggleMarked(for wordCardId: String) {
        if let index = wordCards.firstIndex(where: { $0.id == wordCardId }) {
            wordCards[index].marked.toggle()
        }
    }
    
    func addWordCard(wordCard: WordCard) {
        do {
            let newWordCardRef = db.collection("books").document(book.id).collection("wordCards").document()
            let newWordCardId = newWordCardRef.documentID
            var newWordCard = wordCard
            newWordCard.id = newWordCardId
            
            wordCards.append(newWordCard)
            
            try newWordCardRef.setData(from: newWordCard)
        } catch {
            print("Error adding word card: \(error)")
        }
    }
    
    func deleteWordCard(at offsets: IndexSet) {
        for index in offsets {
            let wordCardId = wordCards[index].id
            db.collection("books").document(book.id).collection("wordCards").document(wordCardId).delete { error in
                if let error = error {
                    print("Error removing word card: \(error)")
                } else {
                    // Also remove it from the local array
                    self.wordCards.remove(atOffsets: offsets)
                }
            }
        }
    }
}

