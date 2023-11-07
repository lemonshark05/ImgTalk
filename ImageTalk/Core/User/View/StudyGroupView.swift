//
//  StudyGroupView.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/11/6.
//

import SwiftUI

struct StudyGroupDetailView: View {
    @ObservedObject var viewModel: StudyGroupViewModel

    init(group: StudyGroup) {
        self.viewModel = StudyGroupViewModel(group: group)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(viewModel.group.name)
                    .font(.largeTitle)
                    .padding(.top)

                Text("Topic: \(viewModel.group.topic)")
                    .font(.title2)

                Divider()

                VStack(alignment: .leading) {
                    Text("Members:")
                        .font(.headline)

                    ForEach(viewModel.group.memberIds, id: \.self) { memberId in
                        Text(memberId) // You may want to fetch and display the username instead of ID
                    }
                }

                // Actions for joining or leaving the group
                if viewModel.isCurrentUserAMember {
                    Button(action: {
                        Task {
                            await viewModel.leaveGroup()
                        }
                    }) {
                        Text("Leave Group")
                            .foregroundColor(.red)
                    }
                } else {
                    Button(action: {
                        Task {
                            await viewModel.joinGroup()
                        }
                    }) {
                        Text("Join Group")
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    StudyGroupDetailView(group: StudyGroup.mockGroup)
                .environmentObject(StudyGroupViewModel(group: StudyGroup.mockGroup)) 
}
