//
//  SearchView.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/11/1.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @StateObject var viewModel = SearchViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Search...", text: $searchText)
                    }
                    .padding(8)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal)
                    
                    LazyVStack(spacing: 12) {
                        ForEach(viewModel.users) { user in
                            NavigationLink(destination: ProfileView(user: user)) {
                                HStack {
                                    Image(uiImage: UIImage(named: user.profileImageUrl ?? "") ?? UIImage())
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 40, height: 40)
                                        .clipShape(Circle())
                                    
                                    VStack(alignment: .leading) {
                                        Text(user.username)
                                            .fontWeight(.semibold)
                                        if let fullname = user.fullname {
                                            Text(fullname)
                                        }
                                    }
                                    .font(.footnote)
                                    
                                    Spacer()
                                }
                                .foregroundColor(.black)
                                .padding(.horizontal)
                            }
                        }
                    }
                    .padding(.top, 8)
                }
            }
            .navigationTitle("Explore")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
