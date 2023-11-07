//
//  AddNewGroupView.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/11/6.
//

import SwiftUI

import SwiftUI
import Firebase

struct AddNewGroupView: View {
    let userId: String
    @Environment(\.dismiss) private var dismiss
    @State private var groupSubject: String = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    init(userId: String) {
        self.userId = userId
    }

    private var db = Firestore.firestore()

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button("Cancel") {
                        dismiss()
                    }
                    Spacer()
                    Text("New Group")
                        .font(.headline)
                        .fontWeight(.semibold)
                    Spacer()
                    Button("Done") {
                        addNewGroup()
                    }
                    .disabled(groupSubject.isEmpty)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                }
                .padding()

                Divider()

                TextField("Group Subject", text: $groupSubject)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Spacer()
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            .navigationTitle("Add New Group")
        }
    }
    
    private func addNewGroup() {
        // Create a new group with default or empty fields as needed
        let newGroup = StudyGroup(
            id: UUID().uuidString,
            name: groupSubject,
            topic: "", // Default or empty value
            memberIds: [], // Start with an empty array of members
            adminId: userId,
            vocabListIds: [],
            quizIds: [],
            linkIds: []
        )

        // Convert the new group to a dictionary for Firebase
        let data = try! JSONEncoder().encode(newGroup)
        let dictionary = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
        
        // Add the group to the Firebase Firestore
        db.collection("studyGroups").document(newGroup.id).setData(dictionary) { error in
            if let error = error {
                // Handle the error
                alertMessage = error.localizedDescription
                showingAlert = true
            } else {
                // Dismiss the view on success
                dismiss()
            }
        }
    }
}

struct AddNewGroupView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewGroupView(userId: "1")
    }
}

