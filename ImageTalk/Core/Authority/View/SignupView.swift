//
//  SignupView.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/11/1.
//

import SwiftUI

struct SignupView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: RegisterViewModel
        
    var body: some View {
        VStack (spacing: 12) {
            Spacer ()
            
            Text ("Welcome to ImageTalk, \(viewModel.username)")
                .font(.title2)
                .fontWeight (.bold)
                .padding (.top)
                .multilineTextAlignment(.center)
            
            Text ("Click below to complete registration and start using imageTalk")
                .font(.footnote)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
            
            Button {
                Task { try await viewModel.createUser() }
            } label: {
                Text ("Complete Sign Up")
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
    SignupView()
}
