//
//  GroupListView.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/11/6.
//

import SwiftUI

struct GroupListView: View {
    @State private var isPresented = false
    @StateObject var viewModel: GroupListViewModel
    
    init(user: User){
        self._viewModel = StateObject(wrappedValue: GroupListViewModel(user: user))
    }

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    Button("New Group") {
                        isPresented = true
                    }
                    Spacer()
                }.padding()

                List(viewModel.studyGroups) { group in
                    NavigationLink(destination: StudyGroupDetailView(group: group)) {
                        HStack {
                            Text(group.name)
                            Spacer()
                            Text("\(group.memberIds.count) members")
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .sheet(isPresented: $isPresented) {
                    AddNewGroupView(userId: viewModel.user.id)
                }
            }
            .navigationTitle("Study Groups")
            .onAppear {
                viewModel.fetchStudyGroups()
            }
        }
    }
}


#Preview {
    GroupListView(user:User.MOCK_USERS[0])
}
