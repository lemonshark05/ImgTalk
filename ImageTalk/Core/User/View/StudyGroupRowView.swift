//
//  StudyGroupRowView.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/11/6.
//

import SwiftUI

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

#Preview {
    StudyGroupRowView(group: StudyGroup.mockGroup)
}
