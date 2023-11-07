//
//  HomePageView.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/11/6.
//

import SwiftUI

struct HomePageView: View {
    @StateObject private var viewModel: HomePageViewModel
    @State private var searchText = ""
    @State private var isPresentingNewGroupView = false
    
    init(user: User){
        self._viewModel = StateObject(wrappedValue: HomePageViewModel(user: user))
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.filteredStudyGroups(with: searchText), id: \.id) { group in
                    NavigationLink(destination: StudyGroupDetailView(group: group)) {
                        StudyGroupRowView(group: group)
                    }
                }
            }
            .navigationTitle("Your Study Groups")
            .searchable(text: $searchText) // Add searchable modifier
            .toolbar { // Use the toolbar to add a button in the navigation bar
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isPresentingNewGroupView = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isPresentingNewGroupView) {
                AddNewGroupView(userId: viewModel.user.id)
            }
            .onAppear {
                viewModel.fetchStudyGroups()
            }
        }
    }
}

#Preview {
    HomePageView(user:User.MOCK_USERS[0])
}
