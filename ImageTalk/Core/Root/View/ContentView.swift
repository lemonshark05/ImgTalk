//
//  ContentView.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/11/4.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    @StateObject var registerViewModel = RegisterViewModel()
    
    var body: some View {
        Group {
            if viewModel.userSession == nil {
                LoginView()
                    .environmentObject(registerViewModel)
            }else {
                MainTabView()
            }
        }
    }
}

#Preview {
    ContentView()
}
