//
//  RegisterViewModel.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/10/6.
//

import SwiftUI

class RegisterViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var fullname = ""
    func createUser () async throws {
        
    }
}
