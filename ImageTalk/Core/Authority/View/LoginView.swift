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
                        .font(.subheadline)
                        .padding(12)
                        .background (Color (.systemGray6))
                        .cornerRadius (10)
                        .padding (.horizontal, 24)
                    SecureField("Enter your password", text: $viewModel.password)
                        .font(.subheadline)
                        .padding(12)
                        .background (Color (.systemGray6))
                        .cornerRadius (10)
                        .padding (.horizontal, 24)
                }
                // forgot password
                Button {
                    print ("Forgot password")
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
                        try await viewModel.login()
                    }
                } label: {
                    Text ("Login" )
                        .font (.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 360, height: 44) .background (Color (.systemBlue))
                        .cornerRadius(10)
                }
                .padding(.vertical)
                // facebook login
                HStack {
                    Rectangle()
                        .frame(width: (UIScreen.main.bounds.width / 2) - 40, height: 0.5)
                    Text ("OR")
                        .font(.footnote)
                        .fontWeight(.semibold)
                    Rectangle ()
                        .frame(width: (UIScreen.main.bounds.width / 2) - 40, height: 0.5)
                }
                .foregroundColor (.gray)
                HStack {
                    Image("facebook-icon")
                        .resizable()
                        .frame (width: 20, height: 20)
                    Text("Continue with Facebook" )
                        .font (. footnote)
                        .fontWeight(.semibold)
                        .foregroundColor (Color (.systemBlue))
                }
                .padding (.top, 8)
                
                Spacer()
                // sign up link
                Divider()
                NavigationLink{
                    RegisterView()
                } label: {
                    HStack(spacing: 3) {
                        Text ("Don't have an account?")
                        Text ("Sign Up")
                            .fontWeight (.semibold)
                    }
                    .font (.footnote)
                }
                .padding(.vertical)
                
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}