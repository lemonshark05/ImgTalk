//
//  LoginView.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/10/6.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                // logo image
                Image ("icon")
                    .resizable ()
                    .scaledToFit ()
                    .frame(width: 180, height: 180)
                    .cornerRadius(10)
                    .padding ()
                
                // text fields
                VStack(spacing: 12) {
                    TextField("Enter your email", text: $viewModel.email)
                        .autocapitalization(.none)
                        .modifier(IGTextFieldModifier())
                    
                    SecureField("Enter your password", text: $viewModel.password)
                        .modifier(IGTextFieldModifier())
                }
                // forgot password
                Button {
                    print ("Show forgot password")
                } label: {
                    Text ("Forgot password?")
                        .font(.footnote)
                        .fontWeight (.semibold)
                        .padding (.top)
                        .padding(.trailing, 28)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                
                // login button
                Button {
                    Task {
                        try await viewModel.signIn()
                    }
                } label: {
                    Text ("Login")
                        .font (.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 360, height: 44) .background (Color (.systemBlue))
                        .cornerRadius(10)
                }
                .padding(.vertical)
                
                Spacer()
               
                Divider()
                
                NavigationLink{
                    AddEmailView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack(spacing: 3) {
                        Text ("Don't have an account?")
                        Text ("Sign Up")
                            .fontWeight (.semibold)
                    }
                    .font (.footnote)
                }
                .padding(.vertical, 16)
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
