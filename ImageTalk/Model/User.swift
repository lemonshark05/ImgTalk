//
//  User.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/10/6.
//

import Foundation

struct User: Codable, Identifiable, Hashable{
    let id: String
    var username: String
    let email: String
    var bio: String?
    var fullname: String?
    var profileImageUrl: String?
}

extension User {
    static var MOCK_USER: [User] = [
        .init(id: NSUUID() .uuidString, username: "Bruce Wayne", email: "Hula", bio: "batman@gmail.com", profileImageUrl: "app-icon")
        ]
}
