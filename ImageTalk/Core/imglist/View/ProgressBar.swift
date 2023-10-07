//
//  ProgressBar.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/9/20.
//

import SwiftUI

struct ProgressBar: View {
    @Binding var value: Double

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color(UIColor.systemTeal))

                Rectangle().frame(width: CGFloat(self.value) * geometry.size.width, height: geometry.size.height)
                    .foregroundColor(Color(UIColor.systemBlue))
                    .animation(.linear)
            }
            .cornerRadius(45.0)
        }
    }
}

struct ProgressBar_Previews: PreviewProvider {
    @State static var value: Double = 0.0
    static var previews: some View {
        ProgressBar(value: $value)
    }
}
