//
//  Book.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/11/6.
//

import Foundation
import Firebase

struct Book: Identifiable, Hashable, Codable {
    let id: String
    var title: String
    var author: String
    var wordCardIds: [String]
    var memberIds: [String]
    
    var isCurrentUserTheAuthor: Bool {
        guard let currentUid = Auth.auth().currentUser?.uid else { return false }
        return author == currentUid
    }
}
