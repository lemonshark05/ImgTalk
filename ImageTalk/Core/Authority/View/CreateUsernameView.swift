//
//  CreateUsernameView.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/11/1.
//

import SwiftUI

struct CreateUsernameView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: RegisterViewModel
    
    var body: some View {
        VStack (spacing: 12) {
            
            Text ("Create username")
                .font(.title2)
                .fontWeight (.bold)
                .padding (.top)
            
            Text ("You'll use this email to sign in to your account")
                .font (. footnote)
                .foregroundColor (.gray)
                .multilineTextAlignment (.center)
                .padding(.horizontal, 24)
            
            TextField("Email", text: $viewModel.username)
                .autocapitalization(.none)
                .modifier(IGTextFieldModifier())
            
            NavigationLink {
                CreatePasswordView()
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
    CreateUsernameView()
}
