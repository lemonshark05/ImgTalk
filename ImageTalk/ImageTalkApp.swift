//
//  ImageTalkApp.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/9/20.
//

import SwiftUI

@main
struct ImageTalkApp: App {
    @StateObject private var testData = TestData() // Replace TestData with your actual environment object
    @StateObject private var audioRecorder = AudioRecord()
        
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ListView()
                    .environmentObject(testData)
                    .environmentObject(audioRecorder)
            }.navigationViewStyle(StackNavigationViewStyle())
        }
    }
}
