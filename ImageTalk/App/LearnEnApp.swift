//
//  LearnEnApp.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/11/4.
//

import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct LearnEnApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var testData = TestData() // Replace TestData with your actual environment object
    @StateObject private var audioRecorder = AudioRecord()
        
//    var body: some Scene {
//        WindowGroup {
//            NavigationView {
//                UserListView()
//                    .environmentObject(testData)
//                    .environmentObject(audioRecorder)
//            }.navigationViewStyle(StackNavigationViewStyle())
//        }
//    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
