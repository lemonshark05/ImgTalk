//
//  User.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/10/6.
//

import Foundation
import Firebase

struct User: Identifiable, Hashable, Codable {
    let id: String
    var username: String
    let email: String
    var bio: String?
    var fullname: String?
    var profileImageUrl: String?
    
    var isCurrentUser: Bool {
        guard let currentUid = Auth.auth().currentUser?.uid else { return false}
        return currentUid == id
    }
}

extension User {
    static var MOCK_USERS: [User] = [
        .init(id: NSUUID() .uuidString, username: "Hula11", email: "batman11@gmail.com", bio: "ling11", fullname: "Bruce Wayne01", profileImageUrl: "1"),
        .init(id: NSUUID() .uuidString, username: "Hula22", email: "batman22@gmail.com", bio: "ling22", fullname: "Bruce Wayne02", profileImageUrl: "3"),
        .init(id: NSUUID() .uuidString, username: "Hula33", email: "batman33@gmail.com", bio: "ling33", fullname: "Bruce Wayne03", profileImageUrl: "4"),
        .init(id: NSUUID() .uuidString, username: "Hula55", email: "batman44@gmail.com", bio: "ling55", fullname: "Bruce Wayne04", profileImageUrl: "5"),
        .init(id: NSUUID() .uuidString, username: "Hula66", email: "batman55@gmail.com", bio: "ling66", fullname: "Bruce Wayne05", profileImageUrl: "6"),
        ]
}
