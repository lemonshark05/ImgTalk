//
//  ProfileView.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/11/1.
//

import SwiftUI

struct ProfileView: View {
    
    let user: User
    
    var posts:[Post]{
        return Post.MOCK_POSTS.filter({
            $0.user?.username == user.username})
    }

    var body: some View {
        NavigationView {
            ScrollView{
                // header
                
                //post graph views
                PostGridView(posts: posts)
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: User.MOCK_USERS[0])
    }
}
