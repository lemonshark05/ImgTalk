//
//  UserService.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/10/6.
//

import Foundation
import Firebase

class UserService {

    static func fetchAllUsers() async throws ->[User] {
        let snapshot = try await Firestore.firestore().collection("users").getDocuments()
        return snapshot.documents.compactMap({ try? $0.data(as: User.self)})
    }
}
