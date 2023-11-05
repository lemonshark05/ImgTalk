//
//  QuestionView.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/11/1.
//

import SwiftUI

struct QuestionView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 30) {
                    ForEach(Post.MOCK_POSTS) { post in
                        QuestionCell(post:post)
                    }
                }
                .padding(.top, 8)
            }
            .navigationTitle("Question")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
//                    Image ("icon")
//                        .resizable()
//                        .frame(width: 100, height: 32)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image (systemName: "paperplane")
                        .imageScale(.large)
                }
            }
        }
    }
}

#Preview {
    QuestionView()
}
