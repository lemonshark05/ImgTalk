//
//  WordCardView.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/10/5.
//

import AVFoundation
import SwiftUI

struct WordCardView: View {
    let wordCard: WordCard
    
    @State private var showDetails: Bool = false

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(wordCard.word)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                
                Spacer()
                
                Button(action: pronounceWord) {
                    Image(systemName: "speaker.3.fill")
                        .font(.largeTitle)
                        .foregroundColor(.blue)
                }
            }
            .padding(.bottom, 8)
            
            Text(wordCard.explanation)
                .font(.body)
                .foregroundColor(.gray)
            
            if !wordCard.synonyms.isEmpty {
                VStack(alignment: .leading) {
                    Text("Synonyms")
                        .font(.headline)
                        .padding(.top)
                    ForEach(wordCard.synonyms, id: \.self) { synonym in
                        Text(synonym)
                            .foregroundColor(.secondary)
                            .padding(.bottom, 2)
                    }
                }
            }
            
            if !wordCard.examples.isEmpty {
                VStack(alignment: .leading) {
                    Text("Examples")
                        .font(.headline)
                        .padding(.top)
                    ForEach(wordCard.examples, id: \.self) { example in
                        Text("•\(example)")
                            .foregroundColor(.secondary)
                            .padding(.bottom, 2)
                    }
                }
            }
            
            Button("Learn More") {
                showDetails.toggle()
            }
            .foregroundColor(.blue)
            .padding(.top, 8)
        }
        .padding(20)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.white, Color.white.opacity(0.9)]), startPoint: .top, endPoint: .bottom)
        )
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10)
        .padding(.horizontal, 15)
        .sheet(isPresented: $showDetails) {
            // TODO: Detailed word view or WebView showing more about the word.
            Text("Details for \(wordCard.word)")
        }
    }
    
    func pronounceWord() {
        let utterance = AVSpeechUtterance(string: wordCard.word)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
}


#Preview {
    WordCardView(wordCard: WordCard(word: "Abundant", explanation: "Present in large quantities",synonyms: ["Plentiful", "Ample"], examples: ["The region had abundant rainfall this year."]))
}
