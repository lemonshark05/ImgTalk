//
//  TextToSpeechView.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/10/10.
//
import SwiftUI
import AVFoundation

struct TextToSpeechView: View {
    @State private var inputText: String = ""
    @State private var audioPlayer: AVAudioPlayer?
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""

    var body: some View {
        VStack {
            Text("Text to Speech")
                .font(.largeTitle)
                .padding()

            TextEditor(text: $inputText)
                .frame(height: 200)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray))

            Spacer() // This pushes the button to the bottom

            Button("Play Speech") {
                fetchAndPlaySpeech(for: inputText)
            }
            .padding()
            .background(inputText.isEmpty ? Color.gray : Color.blue) // Gray out if no input
            .foregroundColor(.white)
            .cornerRadius(10)
            .disabled(inputText.isEmpty) // Disable if no input
        }
        .padding()
        .alert(isPresented: $showAlert) { // Alert for error messages
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }

    func fetchAndPlaySpeech(for text: String) {
        HuggingAPI.textToSpeech(text) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    self.alertMessage = error?.localizedDescription ?? "Unknown error"
                    self.showAlert = true
                }
                return
            }

            DispatchQueue.main.async {
                do {
                    self.audioPlayer = try AVAudioPlayer(data: data)
                    self.audioPlayer?.play()
                } catch {
                    self.alertMessage = "Failed to play audio: \(error)"
                    self.showAlert = true
                }
            }
        }
    }
}

struct TextToSpeechView_Previews: PreviewProvider {
    static var previews: some View {
        TextToSpeechView()
    }
}
