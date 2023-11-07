//
//  StudyGroupViewModel.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/11/4.


import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth

class StudyGroupViewModel: ObservableObject {
    @Published var group: StudyGroup
    @Published var isCurrentUserAMember: Bool = false
    
    private var db = Firestore.firestore()
    private var listenerRegistration: ListenerRegistration?
    
    init(group: StudyGroup) {
        self.group = group
        fetchGroup()
        checkIfCurrentUserIsMember()
    }
    
    func fetchGroup() {
        listenerRegistration = db.collection("studyGroups").document(group.id)
            .addSnapshotListener { [weak self] documentSnapshot, error in
                if let snapshot = documentSnapshot, snapshot.exists {
                    do {
                        self?.group = try snapshot.data(as: StudyGroup.self)
                    } catch let error {
                        print("Error decoding group: \(error)")
                    }
                } else if let error = error {
                    print("Error getting group: \(error)")
                }
            }
    }
    
    func checkIfCurrentUserIsMember() {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        isCurrentUserAMember = group.memberIds.contains(currentUserId)
    }
    
    func joinGroup() async {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        do {
            // Add user to the group's member list
            try await db.collection("studyGroups").document(group.id).updateData([
                "memberIds": FieldValue.arrayUnion([currentUserId])
            ])

            // Update local state
            self.isCurrentUserAMember = true
        } catch let error {
            print("Error joining group: \(error)")
        }
    }
    
    func leaveGroup() async {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        do {
            // Remove user from the group's member list
            try await db.collection("studyGroups").document(group.id).updateData([
                "memberIds": FieldValue.arrayRemove([currentUserId])
            ])
            
            // Update local state
            self.isCurrentUserAMember = false
        } catch let error {
            print("Error leaving group: \(error)")
        }
    }
    
    func addLink(_ newLink: String, description: String) async {
        let link = Link(id: UUID().uuidString, url: newLink, description: description)
        do {
            let _ = try await db.collection("links").document(link.id).setData(from: link)
            group.linkIds.append(link.id)
            await updateStudyGroupLinks()
        } catch let error {
            print("Error adding link: \(error)")
        }
    }
    
    func addVocabWord(_ newWord: String) async {
        let vocabList = VocabList(id: UUID().uuidString, words: [newWord])
        do {
            let _ = try await db.collection("vocabLists").document(vocabList.id).setData(from: vocabList)
            group.vocabListIds.append(vocabList.id)
            await updateStudyGroupVocabLists()
        } catch let error {
            print("Error adding vocab word: \(error)")
        }
    }
    
    func addQuiz(_ title: String, questions: String) async {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        let quiz = Quiz(id: UUID().uuidString, title: title, questions: questions, authorId: currentUserId)
        do {
            let _ = try await db.collection("quizzes").document(quiz.id).setData(from: quiz)
            group.quizIds.append(quiz.id)
            await updateStudyGroupQuizzes()
        } catch let error {
            print("Error creating quiz: \(error)")
        }
    }
    
    // Update functions
    func updateStudyGroupLinks() async {
        do {
            try await db.collection("studyGroups").document(group.id)
                .updateData(["linkIds": FieldValue.arrayUnion([group.linkIds.last])])
        } catch let error {
            print("Error updating study group with new link: \(error)")
        }
    }
    
    func updateStudyGroupVocabLists() async {
        do {
            try await db.collection("studyGroups").document(group.id)
                .updateData(["vocabListIds": FieldValue.arrayUnion([group.vocabListIds.last])])
        } catch let error {
            print("Error updating study group with new vocab list: \(error)")
        }
    }
    
    func updateStudyGroupQuizzes() async {
        do {
            try await db.collection("studyGroups").document(group.id)
                .updateData(["quizIds": FieldValue.arrayUnion([group.quizIds.last])])
        } catch let error {
            print("Error updating study group with new quiz: \(error)")
        }
    }
    deinit {
        // Remove the listener when this object is deinitialized
        listenerRegistration?.remove()
    }
}
