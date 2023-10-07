//
//  UserService.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/10/6.
//

import Foundation
class UserService {
    
    @Published var currentUser: User?
    
    static let shared = UserService()
    
}
