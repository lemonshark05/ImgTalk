//
//  ListView.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/9/20.
//

import SwiftUI

struct ListView: View {
    @StateObject private var testData = TestData()
    @EnvironmentObject var audioRecorder: AudioRecord
    @State private var showingTextToSpeech = false

    var body: some View {
        VStack{
            List(testData.tests) { test in
                NavigationLink(destination: imagesView(imageName: test.imageRoute, text: test.info)) {
                    HStack {
                        Image(test.imageRoute)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                        Text(test.name)
                    }
                }
            }.navigationBarTitle("Picture Talk")
            
            Spacer()
            
            Button("Upload Text") {
                showingTextToSpeech = true
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .sheet(isPresented: $showingTextToSpeech) {
            TextToSpeechView()
        }
    }
}

struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}

