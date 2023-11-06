//
//  ProfileHeaderView.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/11/4.
//

import SwiftUI

struct ProfileHeaderView: View {
    let user: User
    @State private var showEditProfile = false
    
    var body: some View {
        VStack(spacing: 10){
            // pic and stats
            HStack {
                Image (user.profileImageUrl ?? "")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape (Circle())
                HStack(spacing: 8) {
                    UserStatView(value: 3, title: "Posts")
                    UserStatView(value: 3, title: "Followers")
                    UserStatView(value: 3, title: "Following")
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 8)
            
            // name and bio
            VStack(alignment: .leading,spacing: 4) {
                if let fullname = user.fullname{
                    Text(fullname)
                        .font (.footnote)
                        .fontWeight (.semibold)
                }
                if let bio = user.bio{
                    Text (bio)
                        .font(.footnote)
                }
                Text(user.username)
            }
            .frame(maxWidth: .infinity, alignment:.leading)
            .padding (.horizontal)
            // action button
            Button {
                if user.isCurrentUser {
                    showEditProfile.toggle()
                } else {
                    print("Follow this user..")
                }
            } label: {
                Text(user.isCurrentUser ? "Edit Profile":"Follow")
                    .font (.subheadline)
                    .fontWeight (.semibold)
                    .frame(width: 360, height: 32)
                    .background(user.isCurrentUser ? .white: Color(.systemBlue))
                    .foregroundColor (user.isCurrentUser ? .black: .white)
                    .cornerRadius(6)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(user.isCurrentUser ? Color.gray: .clear, lineWidth: 1)
                    )
            }
            
            Divider()
        }
        .fullScreenCover(isPresented: $showEditProfile, content: {
            Text("Edit profile view")
        })
    }
}

#Preview {
    ProfileHeaderView(user:User.MOCK_USERS[0])
}
