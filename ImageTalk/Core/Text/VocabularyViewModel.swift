//
//  VocabularyViewModel.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/11/3.
//

import Firebase

class VocabularyViewModel: ObservableObject {
    @Published var wordCards: [WordCard] = []

    private var db = Firestore.firestore()
    
    init() {
        loadData()
    }
    
    func loadData() {
        db.collection("vocabulary").order(by: "createdAt", descending: true).addSnapshotListener { (querySnapshot, error) in
            if let querySnapshot = querySnapshot {
                self.wordCards = querySnapshot.documents.compactMap { document -> WordCard? in
                    try? document.data(as: WordCard.self)
                }
            }
        }
    }
    
    func addWordCard(wordCard: WordCard) {
        do {
            _ = try db.collection("vocabulary").addDocument(from: wordCard)
        } catch {
            print(error)
        }
    }
    
    func deleteWordCard(at offsets: IndexSet) {
        offsets.forEach { index in
            let wordCard = wordCards[index]
            if let documentId = wordCard.id {
                db.collection("vocabulary").document(documentId).delete() { error in
                    if let error = error {
                        print("Unable to remove document: \(error)")
                    }
                }
            }
        }
    }
}
