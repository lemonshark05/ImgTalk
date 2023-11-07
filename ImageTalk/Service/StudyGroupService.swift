//
//  StudyGroupService.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/11/6.
//

import Foundation
import Firebase

class StudyGroupService {

    static func fetchStudyGroups() async throws ->[StudyGroup] {
        let snapshot = try await Firestore.firestore().collection("studyGroups").getDocuments()
        return snapshot.documents.compactMap({ try? $0.data(as: StudyGroup.self)})
    }
}
