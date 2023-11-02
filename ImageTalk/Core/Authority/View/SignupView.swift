//
//  SignupView.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/11/1.
//

import SwiftUI

struct SignupView: View {
    @Environment(\.presentationMode) var presentationMode
        
    var body: some View {
        VStack (spacing: 12) {
            Spacer ()
            
            Text ("Welcome to ImageTalk!")
                .font(.title2)
                .fontWeight (.bold)
                .padding (.top)
            
            Text ("Click below to complete registration and start using imageTalk")
                .font(.footnote)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
            
            Button {
                print("Complete sign up")
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
