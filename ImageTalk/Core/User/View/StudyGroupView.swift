//
//  StudyGroupView.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/11/6.
//

import SwiftUI

struct StudyGroupDetailView: View {
    @ObservedObject var viewModel: StudyGroupViewModel

    @State private var newLink = ""
    @State private var linkDescription = ""
    @State private var newWord = ""
    @State private var quizQuestions = ""
    @State private var newQuizTitle = ""
    
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
                
                if viewModel.isCurrentUserAMember {

                    // Section to add new vocab
                    VStack {
                        TextField("Add a new word", text: $newWord)
                        // ... additional fields if necessary
                        Button("Add Word") {
                            Task {
                                await viewModel.addVocabWord(newWord)
                                newWord = ""
                            }
                        }
                    }

                    // Section to add new quiz
                    VStack {
                        TextField("New Quiz Title", text: $newQuizTitle)
                        TextField("Detail", text: $quizQuestions)
                        Button("Create Quiz") {
                            Task {
                                await viewModel.addQuiz(newQuizTitle, questions: quizQuestions)
                                newQuizTitle = ""
                                quizQuestions = ""
                            }
                        }
                    }
                    
                    // Section to add new link
                    VStack {
                        TextField("Share a new link", text: $newLink)
                        TextField("Link description", text: $linkDescription)
                        Button("Add Link") {
                            Task {
                                await viewModel.addLink(newLink, description: linkDescription)
                                newLink = ""
                                linkDescription = "" // Reset text fields
                            }
                        }
                    }

                    // showing only the five words
                    List(viewModel.group.vocabListIds.prefix(5), id: \.self) { vocabListId in
                        // Fetch and display vocab details
                    }

                    //showing only the latest three quizzes
                    List(viewModel.group.quizIds.prefix(3), id: \.self) { quizId in
                        // Fetch and display quiz details
                    }
                    
                    List(viewModel.group.linkIds.prefix(3), id: \.self) { linkId in
                        // Fetch and display link details
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
