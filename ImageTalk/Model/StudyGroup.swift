//
//  StudyGroup.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/11/4.
//

import Foundation
import Firebase

struct StudyGroup: Identifiable, Hashable, Codable {
    let id: String
    var name: String
    var topic: String
    var memberIds: [String]
    var adminId: String
    var vocabListIds: [String]
    var quizIds: [String]
    var linkIds: [String]
    
    var isCurrentUserAMember: Bool {
        guard let currentUid = Auth.auth().currentUser?.uid else { return false }
        return memberIds.contains(currentUid)
    }
}

struct VocabList: Identifiable, Hashable, Codable {
    let id: String
    var words: [String]
}

struct Quiz: Identifiable, Hashable, Codable {
    let id: String
    var title: String
    var questions: String
    var authorId: String
}

struct Link: Identifiable, Hashable, Codable {
    let id: String
    var url: String
    var description: String
}

extension StudyGroup {
    static var mockGroup: StudyGroup {
        return StudyGroup(id: "001", name: "Study Group 1", topic: "SwiftUI", memberIds: ["member1", "member2"], adminId: "admin", vocabListIds: [], quizIds: [], linkIds: [])
    }
}
