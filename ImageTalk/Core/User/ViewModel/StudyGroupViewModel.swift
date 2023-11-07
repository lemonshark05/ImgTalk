//
//  StudyGroupViewModel.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/11/6.
//

import Firebase

class StudyGroupViewModel: ObservableObject {
    @Published var group: StudyGroup
    @Published var isCurrentUserAMember: Bool = false

    init(group: StudyGroup) {
        self.group = group
        checkIfCurrentUserIsMember()
    }
    
    private var db = Firestore.firestore()
    
    func checkIfCurrentUserIsMember() {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        isCurrentUserAMember = group.memberIds.contains(currentUserId)
    }
    
    func joinGroup() async {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        
        db.collection("studyGroups").document(group.id).updateData([
            "memberIds": FieldValue.arrayUnion([currentUserId])
        ]) { error in
            if let error = error {
                print("Error joining group: \(error)")
            } else {
                self.isCurrentUserAMember = true
            }
        }
        
        // Add this group to the user's list of groups
        db.collection("users").document(currentUserId).updateData([
            "groupIds": FieldValue.arrayUnion([group.id])
        ]) { error in
            if let error = error {
                print("Error updating user groups: \(error)")
            }
        }
    }

    func leaveGroup() async {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        
        db.collection("studyGroups").document(group.id).updateData([
            "memberIds": FieldValue.arrayRemove([currentUserId])
        ]) { error in
            if let error = error {
                print("Error leaving group: \(error)")
            } else {
                self.isCurrentUserAMember = false
            }
        }
        
        // Remove this group from the user's list of groups
        db.collection("users").document(currentUserId).updateData([
            "groupIds": FieldValue.arrayRemove([group.id])
        ]) { error in
            if let error = error {
                print("Error updating user groups: \(error)")
            }
        }
    }
}
