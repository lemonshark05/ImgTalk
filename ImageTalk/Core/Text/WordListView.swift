//
//  WordListView.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/11/5.
//

import SwiftUI

struct WordListView: View {
    @State private var words: [WordCard] = []
    
    var body: some View {
        List(words) { wordCard in
            WordCardView(wordCard: wordCard)
        }
        .onAppear {
            loadWords()
        }
    }
    
    private func loadWords() {
        // Corrected the path to the CSV file location
        if let url = Bundle.main.url(forResource: "words", withExtension: "csv", subdirectory: "ImageTalk/Words") {
            let parser = CSVParser()
            if let loadedWords = parser.loadCSV(contentsOfURL: url) {
                self.words = loadedWords
            }
        }
    }
}

#Preview {
    WordListView()
}
