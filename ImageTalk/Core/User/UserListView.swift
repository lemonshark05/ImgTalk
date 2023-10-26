//
//  UserList.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/10/25.
//

import SwiftUI

struct UserListView: View {
    @StateObject private var testData = TestData()
    @EnvironmentObject var audioRecorder: AudioRecord
    @State private var showingTextToSpeech = false
    @State private var showingRecord = false

    var body: some View {
        VStack{
            Spacer()
            Button("Record speech") {
                showingRecord = true
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            Spacer()
            Button("Upload Text") {
                showingTextToSpeech = true
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            Spacer()
        }
        .sheet(isPresented: $showingTextToSpeech) {
            TextToSpeechView()
        }
        .sheet(isPresented: $showingRecord) {
            SpeechToTextView()
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
