//
//  SearchView.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/11/1.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @State private var searchContext = "Users"
    @StateObject var viewModel = SearchViewModel()
    
    let searchOptions = ["Users", "Study Groups"]
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Search Context", selection: $searchContext) {
                    ForEach(searchOptions, id: \.self) { option in
                        Text(option).tag(option)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                TextField("Search...", text: $searchText)
                    .padding(8)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                ScrollView {
                    LazyVStack(spacing: 12) {
                        if searchContext == "Users" {
                            ForEach(viewModel.filteredUsers(with: searchText)) { user in
                                NavigationLink(destination: ProfileView(user: user)) {
                                    UserRowView(user: user)
                                }
                            }
                        } else {
                            ForEach(viewModel.filteredStudyGroups(with: searchText)) { group in
                                NavigationLink(destination: StudyGroupDetailView(group: group)) {
                                    StudyGroupRowView(group: group)
                                }
                            }
                        }
                    }
                    .padding(.top, 8)
                }
            }
            .navigationTitle("Search")
        }
    }
}

extension SearchView {
    struct UserRowView: View {
        let user: User
        
        var body: some View {
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
    
    struct StudyGroupRowView: View {
        let group: StudyGroup
            
        var body: some View {
            HStack {
                // Placeholder for group image or icon
                Image(systemName: "person.3.fill") // Example system icon
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.blue)
                    .padding(.trailing, 8)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(group.name)
                        .fontWeight(.semibold)
                    Text("\(group.memberIds.count) members")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                // Optional: Add an arrow or some indicator
                Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal)
            .frame(height: 60)
            .background(Color.white)
            .cornerRadius(8)
            .shadow(radius: 1)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
