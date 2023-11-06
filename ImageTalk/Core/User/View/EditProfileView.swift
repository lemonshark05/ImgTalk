//
//  EditProfileView.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/11/4.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    @Environment(\.dismiss) var dimiss
    @State private var selectedImage: PhotosPickerItem?
    @State private var fullname = ""
    @State private var bio = ""
    
    var body: some View {
        VStack{
            HStack {
                Button {
                }label: {
                    Text("Cancel")
                }
                
                Spacer()
                
                Text("Edit Profile")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button {
                    print("Upload")
                }label: {
                    Text("Done")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
            }
            .padding(.horizontal)
            
            Divider()
        }
        
        PhotosPicker(selection: $selectedImage) {
            VStack {
                Image(systemName: "person")
                    .resizable()
                    .foregroundColor(.white)
                    .background(.gray)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .frame(width: 80, height: 80)
                
                Text("Edit profile picture")
                    .font(.footnote)
                    .fontWeight(.semibold)
                
                Divider()
            }
        }
        .padding(.vertical, 8)
        
        VStack {
            EditProfileRowView(title: "Name", placeholder: "Enter your name", text: $fullname)
            
            EditProfileRowView(title: "Bio", placeholder: "Enter your bio", text: $bio)

        }
        
        Spacer()
    }
}

struct EditProfileRowView: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        HStack {
            Text(title)
                .padding(.leading, 8)
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .leading)
            
            VStack {
                TextField(placeholder, text: $text)
                
                Divider()
            }
        }
        .font(.subheadline)
        .frame(height: 36)
    }
}

#Preview {
    EditProfileView()
}
