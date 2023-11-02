//
//  CreatePasswordView.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/11/1.
//

import SwiftUI

struct CreatePasswordView: View {
    @State private var password = ""
    @Environment(\.presentationMode) var presentationMode
        
    var body: some View {
        VStack (spacing: 12) {
            
            Text ("Create your Password")
                .font(.title2)
                .fontWeight (.bold)
                .padding (.top)
            
            Text ("Your password must be at least 6 characters in length")
                .font(.footnote)
                .foregroundColor (.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
            
            TextField("Password", text: $password)
                .autocapitalization(.none)
                .modifier(IGTextFieldModifier())
                .padding(.top)
            
            NavigationLink {
                CreateUsernameView()
                    .navigationBarBackButtonHidden(true)
            } label: {
                Text ("Next")
                    .font (. subheadline)
                    .fontWeight (.semibold)
                    .foregroundColor (.white)
                    .frame (width: 360, height:44)
                    .background(Color(.systemBlue))
                    .cornerRadius (8)
            }
            .padding (.vertical)
            
            Spacer ()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Image (systemName: "chevron.left")
                    .imageScale(.large)
                    .onTapGesture {
                        self.presentationMode.wrappedValue.dismiss()
                    }
            }
        }
    }
}

#Preview {
    CreatePasswordView()
}
