//
//  User.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/10/6.
//

import Foundation

struct User: Codable, Identifiable, Hashable{
    var id = NSUUID() .uuidString
    let fullname: String
    let email: String
    var profileImageUrl: String?
}

extension User {
    static let MOCK_USER = User(fullname: "Bruce Wayne", email: "batman@gmail.com", profileImageUrl: "app-icon")
}
