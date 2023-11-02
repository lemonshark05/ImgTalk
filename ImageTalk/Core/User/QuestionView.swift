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
                    ForEach(0...10, id: \.self) { post in
                        QuestionCell()
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
