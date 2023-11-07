//
//  HomePageViewModel.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/11/6.
//

import SwiftUI
import Firebase

class HomePageViewModel: ObservableObject {
    @Published var user: User
    @Published var studyGroups: [StudyGroup] = []
    @Published var latestQuizTitles: [String: String] = [:]
    private var db = Firestore.firestore()
    
    init(user: User) {
        self.user = user
        fetchStudyGroups()
    }
    
    func fetchStudyGroups() {
        db.collection("studyGroups")
            .whereField("memberIds", arrayContains: user.id)
            .addSnapshotListener { [weak self] (querySnapshot, error) in
                guard let snapshot = querySnapshot else {
                    print("Error fetching snapshots: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                
                let groups = snapshot.documents.compactMap { document -> StudyGroup? in
                    try? document.data(as: StudyGroup.self)
                }
                self?.studyGroups = groups
                groups.forEach { group in
                    self?.fetchLatestQuizTitle(forGroup: group)
                }
            }
    }
    
    func fetchLatestQuizTitle(forGroup group: StudyGroup) {
        guard let latestQuizId = group.quizIds.last else {
            latestQuizTitles[group.id] = "No quizzes yet"
            return
        }
        
        db.collection("quizzes").document(latestQuizId).getDocument { [weak self] (document, error) in
            if let document = document, document.exists {
                do {
                    let quiz = try document.data(as: Quiz.self)
                    DispatchQueue.main.async {
                        self?.latestQuizTitles[group.id] = quiz.title
                    }
                } catch {
                    print("Error decoding quiz: \(error.localizedDescription)")
                }
            } else {
                print("Document does not exist: \(error?.localizedDescription ?? "Unknown error")")
                DispatchQueue.main.async {
                    self?.latestQuizTitles[group.id] = "No quizzes yet"
                }
            }
        }
    }
    func filteredStudyGroups(with searchText: String) -> [StudyGroup] {
        if searchText.isEmpty {
            return studyGroups
        } else {
            return studyGroups.filter { group in
                group.name.lowercased().contains(searchText.lowercased())
            }
        }
    }
}
