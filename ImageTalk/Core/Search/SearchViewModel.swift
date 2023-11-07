//
//  SearchViewModel.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/11/5.
//

import Foundation

class SearchViewModel: ObservableObject {
    @Published var users = [User]()
    @Published var studyGroups = [StudyGroup]()
    
    init() {
        Task { try await fetchAllUsers() }
        Task { try await fetchStudyGroups() }
    }
    
    @MainActor
    func fetchAllUsers() async throws {
        self.users = try await UserService.fetchAllUsers()
    }
    
    @MainActor
    func fetchStudyGroups() async throws {
        self.studyGroups = try await StudyGroupService.fetchStudyGroups()
    }
    
    func filteredUsers(with query: String) -> [User] {
        guard !query.isEmpty else { return users }
        return users.filter { $0.username.lowercased().contains(query.lowercased()) }
    }
    
    func filteredStudyGroups(with query: String) -> [StudyGroup] {
        guard !query.isEmpty else { return studyGroups }
        return studyGroups.filter { $0.name.lowercased().contains(query.lowercased()) }
    }
}

