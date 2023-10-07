//
//  Message.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/10/6.
//

import Foundation

struct Message: Identifiable, Codable, Hashable {
    var messageId: String?
    let fromId: String
    let told: String
    let messageText: String
    
    var user: User?
    
    var id: String {
        return messageId ?? NSUUID().uuidString
    }

}
