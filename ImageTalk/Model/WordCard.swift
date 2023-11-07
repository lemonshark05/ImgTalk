//
//  WordCard.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/11/5.
//

import Foundation
import Firebase

struct WordCard: Identifiable, Hashable, Codable {
    var id: String
    var word: String
    var explanation: String
    var synonyms: [String]
    var examples: [String]
    var bookIds: [String]
    var wrongTimes: Int
    var marked: Bool
}

