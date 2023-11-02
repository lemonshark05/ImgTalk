//
//  QuestionCell.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/11/1.
//

import SwiftUI

struct QuestionCell: View {
    var body: some View {
        VStack {
            // image + username
            HStack{
                Image("3" )
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height:40)
                    .clipShape(Circle())
                Text ("Title?")
                    .font(.footnote)
                    .fontWeight(.semibold)
                Spacer ()
            }
            .padding (.leading, 8)
            
            // post image
            Image ("4")
                .resizable()
                .scaledToFill()
                .frame(height: 400)
                .clipShape(Rectangle())
            
            // action buttons
            HStack(spacing: 8) {
                Button {
                    print("Like post")
                }label: {
                    Image (systemName: "heart")
                        .imageScale(.large)
                }
                
                Button {
                    print("Comment on post")
                }label: {
                    Image (systemName: "bubble.right")
                        .imageScale(.large)
                }
                
                Button {
                    print("Share post")
                }label: {
                    Image (systemName: "paperplane")
                        .imageScale(.large)
                }
                
                Spacer()
            }
            .padding(.leading, 8)
            .padding(.top, 4)
            .foregroundColor(.black)
            
            // like label
            Text("23 likes")
                .font(.footnote)
                .fontWeight(.semibold)
                .frame (maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 10)
                .padding (.top, 1)
            // caption label
            HStack {
                Text("batman ").fontWeight(.semibold)
                Text("This is some test caption for now this is some test caption")
            }
            .frame (maxWidth: .infinity, alignment:.leading)
            .font (.footnote)
            .padding (.leading, 10)
            .padding (.top, 1)
            
            Text ("6h ago")
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding (.leading, 10)
                .padding (.top, 1)
                .foregroundColor (.gray)
            // caption label
            
        }
    }
}

#Preview {
    QuestionCell()
}
