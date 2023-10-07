//
//  LoginViewModel.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/10/6.
//

import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    func login() async throws {
        
    }
}
