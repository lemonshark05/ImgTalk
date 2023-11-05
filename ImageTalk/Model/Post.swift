//
//  Post.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/11/1.
//

import Foundation

struct Post: Identifiable, Hashable, Codable {
    let id: String
    let ownerUid: String
    let caption: String
    var likes: Int
    let imageUrl: String
    let timestamp: Date
    var user: User?
}

extension Post {
    static var MOCK_POSTS: [Post] = [
        .init(id: NSUUID().uuidString,
              ownerUid: NSUUID().uuidString,
              caption: "This is some test caption for name",
              likes: 25,
              imageUrl: "8",
              timestamp: Date(),
              user: User.MOCK_USERS[0]),
        .init(id: NSUUID().uuidString,
              ownerUid: NSUUID().uuidString,
              caption: "This is some test caption for name",
              likes: 120,
              imageUrl: "9",
              timestamp: Date(),
              user: User.MOCK_USERS[0]),
        .init(id: NSUUID().uuidString,
              ownerUid: NSUUID().uuidString,
              caption: "This is some test caption for name",
              likes: 87,
              imageUrl: "1",
              timestamp: Date(),
              user: User.MOCK_USERS[2]),
        .init(id: NSUUID().uuidString,
              ownerUid: NSUUID().uuidString,
              caption: "This is some test caption for name",
              likes: 15,
              imageUrl: "3",
              timestamp: Date(),
              user: User.MOCK_USERS[3]),
        .init(id: NSUUID().uuidString,
              ownerUid: NSUUID().uuidString,
              caption: "This is some test caption for name",
              likes: 102,
              imageUrl: "5",
              timestamp: Date(),
              user: User.MOCK_USERS[4])
    ]
}
    
