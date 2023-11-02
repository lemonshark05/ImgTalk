//
//  MainTabView.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/11/1.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            QuestionView()
                .tabItem{
                    Image (systemName: "house")
                }
            SearchView()
                .tabItem{
                Image (systemName: "magnifyingglass")
            }
            Text("Upload Post")
                .tabItem{
                    Image (systemName: "plus.square")
                }
            Text("Notifications")
                .tabItem{
                    Image (systemName: "heart")
                }
            ProfileView()
                .tabItem{
                    Image (systemName: "person")
                }
        }
        .accentColor(.blue)
    }
}
struct MainTabView_Previews: PreviewProvider {
    
    static var previews: some View {
        MainTabView()
        
    }
}
