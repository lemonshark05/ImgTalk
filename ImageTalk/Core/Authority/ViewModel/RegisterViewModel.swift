//
//  RegisterViewModel.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/10/6.
//

import SwiftUI

class RegisterViewModel: ObservableObject {
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    
    func createUser () async throws {
        try await AuthService.shared.createUser(email: email, password: password, username: username)
        
        username = ""
        email = ""
        password = ""
    }
}
