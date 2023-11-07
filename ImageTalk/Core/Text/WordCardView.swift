//
//  WordCardView.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/10/5.
//

import AVFoundation
import SwiftUI
import Speech

struct WordCardView: View {
    let wordCard: WordCard
    @ObservedObject var viewModel: BookViewModel
    @State private var showDetails: Bool = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var audioPlayer: AVAudioPlayer?
    
    @State private var speechRecognizer = SFSpeechRecognizer()
    @State private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    @State private var recognitionTask: SFSpeechRecognitionTask?
    @State private var audioEngine = AVAudioEngine()

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(wordCard.word)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                
                Image(systemName: wordCard.marked ? "star.fill" : "star")
                    .foregroundColor(wordCard.marked ? .yellow : .gray)
                    .onTapGesture {
                        viewModel.toggleMarked(for: wordCard.id)
                    }
                    .padding(.leading, 5)
                
                Spacer()
                
                Button(action: pronounceWord) {
                    Image(systemName: "speaker.3.fill")
                        .font(.largeTitle)
                        .foregroundColor(.blue)
                }
            }
            .padding(.bottom, 8)
            
            if wordCard.wrongTimes > 0 {
                HStack {
                    Text("Mistakes: \(wordCard.wrongTimes)")
                        .font(.subheadline)
                        .foregroundColor(.red)
                    Spacer()
                }
            }
            
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
            
            Button("Check Pronunciation") {
                self.startListeningAndTranscribing()
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
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Pronunciation"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    func pronounceWord() {
        // Combine all the word card details into one string
        let combinedText = """
        \(wordCard.word).
        \(wordCard.explanation).
        Synonyms: \(wordCard.synonyms.joined(separator: "; ")).
        Examples: \(wordCard.examples.joined(separator: "; ")).
        """
        
        // Call the fetchAndPlaySpeech function with the combined text
        fetchAndPlaySpeech(for: combinedText)
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
                    self.alertMessage = "Failed to play audio: \(error.localizedDescription)"
                    self.showAlert = true
                }
            }
        }
    }
    private func startListeningAndTranscribing() {
        // Check if audioEngine is already running
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
        } else {
            try? startSpeechRecognition()
        }
    }

    private func startSpeechRecognition() throws {
        // Cancel the previous task if it's running
        recognitionTask?.cancel()
        self.recognitionTask = nil
        
        // Configure the audio session for the app
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        let inputNode = audioEngine.inputNode
        
        // Create a new recognition request
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = recognitionRequest else { fatalError("Unable to create a recognition request") }
        recognitionRequest.shouldReportPartialResults = false
        
        // Start recognition
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest) { result, error in
            if let result = result {
                let recognizedText = result.bestTranscription.formattedString
                self.checkPronunciation(recognizedText: recognizedText)
            }
            // Stop the audio engine if there's an error or if recognition is complete
            if error != nil || result?.isFinal == true {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
            }
        }
        
        // Configure the microphone input
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.removeTap(onBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            recognitionRequest.append(buffer)
        }
        
        // Prepare and start the audio engine
        audioEngine.prepare()
        try audioEngine.start()
    }
    
    private func checkPronunciation(recognizedText: String) {
        // Check pronunciation
        if recognizedText.lowercased() == wordCard.word.lowercased() {
            self.alertMessage = "Great job! Your pronunciation is correct."
        } else {
            self.alertMessage = "Keep practicing! Try to say: \(wordCard.word)"
        }
        self.showAlert = true
        
        // Reset recognition
        self.audioEngine.stop()
        self.recognitionRequest?.endAudio()
        self.recognitionTask?.cancel()
        self.recognitionTask = nil
    }

}


struct WordCardView_Previews: PreviewProvider {
    static let sampleBook = Book(
        id: "book1",
        title: "Sample Book",
        author: "AuthorID",
        wordCardIds: [],
        memberIds: []
    )

    static let sampleWordCard = WordCard(
        id: "1",
        word: "Abundant",
        explanation: "Existing or available in large quantities; plentiful.",
        synonyms: ["ample", "bountiful", "copious"],
        examples: ["There is abundant evidence that cars contribute to global pollution."],
        bookIds: ["book1"],
        wrongTimes: 2,
        marked: true
    )
    
    static var previews: some View {
        // Initialize the BookViewModel with the sample book
        let viewModel = BookViewModel(book: sampleBook)
        
        // Pass the sample word card and view model to the WordCardView
        WordCardView(wordCard: sampleWordCard, viewModel: viewModel)
    }
}
