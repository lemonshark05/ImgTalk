//
//  MainTabView.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/11/1.
//

import SwiftUI

struct MainTabView: View {
    let user: User
    @State private var selectedIndex = 0
    
    var body: some View {
        NavigationView {
            TabView(selection: $selectedIndex){
                HomePageView(user: user)
                    .onAppear {
                        selectedIndex = 0
                    }
                    .tabItem{
                        Image (systemName: "house")
                    }.tag(0)
                SearchView()
                    .onAppear {
                        selectedIndex = 1
                    }
                    .tabItem{
                        Image (systemName: "magnifyingglass")
                    }.tag(1)
                
                BookListView()
                    .onAppear {
                        selectedIndex = 2
                    }
                    .tabItem{
                        Image (systemName: "plus.square")
                    }.tag(2)
                
                ListView()
                    .onAppear {
                        selectedIndex = 3
                    }
                    .tabItem{
                        Image (systemName: "photo.on.rectangle")
                    }.tag(3)
                
                CurrentProfileView(user: user)
                    .onAppear {
                        selectedIndex = 4
                    }
                    .tabItem{
                        Image (systemName: "person")
                    }.tag(4)
            }
            .accentColor(.blue)
        }
    }
}
struct MainTabView_Previews: PreviewProvider {
    
    static var previews: some View {
        MainTabView(user: User.MOCK_USERS[0])
        
    }
}
