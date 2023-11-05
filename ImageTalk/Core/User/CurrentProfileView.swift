//
//  CurrentProfileView.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/11/1.
//

import SwiftUI

struct CurrentProfileView: View {
    
    let user: User
    
    var posts:[Post]{
        return Post.MOCK_POSTS.filter({
            $0.user?.username == user.username})
    }
    
    var body: some View {
        NavigationView {
            ScrollView{
                // header
                ProfileHeaderView(user: user)
                //post graph views
                PostGridView(posts: posts)
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button {
                        AuthService.shared.signout()
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
}

#Preview {
    CurrentProfileView(user: User.MOCK_USERS[0])
}
