//
//  ListView.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/9/20.
//

import SwiftUI

struct ListView: View {
    @StateObject private var testData = TestData()
    @EnvironmentObject var audioRecorder: AudioRecord

    var body: some View {
        List(testData.tests) { test in
            NavigationLink(destination: RecorderAndPlayerView()){
                Text(test.name)
            }
            .navigationBarTitle("看图说话")
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}

