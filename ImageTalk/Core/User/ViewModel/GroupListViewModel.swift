import Foundation
import Firebase

class GroupListViewModel: ObservableObject {
    @Published var user: User
    init(user: User){
        self.user = user
    }
    @Published var studyGroups = [StudyGroup]()

    private var db = Firestore.firestore()

    func fetchStudyGroups() {
        db.collection("studyGroups").addSnapshotListener { [weak self] (querySnapshot, error) in
            guard let self = self, let documents = querySnapshot?.documents else {
                print("No documents in 'studyGroups' or self is nil")
                return
            }

            DispatchQueue.main.async {
                self.studyGroups = documents.map { queryDocumentSnapshot -> StudyGroup in
                    let data = queryDocumentSnapshot.data()
                    let id = queryDocumentSnapshot.documentID
                    let name = data["name"] as? String ?? ""
                    let topic = data["topic"] as? String ?? ""
                    let memberIds = data["memberIds"] as? [String] ?? []
                    let adminId = data["adminId"] as? String ?? ""
                    let vocabListIds = data["vocabListIds"] as? [String] ?? []
                    let quizIds = data["quizIds"] as? [String] ?? []
                    let linkIds = data["linkIds"] as? [String] ?? []
                    
                    return StudyGroup(id: id, name: name, topic: topic, memberIds: memberIds, adminId: adminId, vocabListIds: vocabListIds, quizIds: quizIds, linkIds: linkIds)
                }
            }
        }
    }
}
