//
//  SpeechToTextView.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/10/12.
//

import SwiftUI
import Speech
import AVFoundation

struct SpeechToTextView: View {
    @ObservedObject var audioRecorder = AudioRecord()
    @StateObject private var testData = TestData()
    @State private var transcribedText = ""
    @State private var isTranscribing = false
    @State private var isRecording = false
    @State private var prepareProgress: Double = 0
    @State private var recordProgress: Double = 0
    @State private var showAlert = false
    @State private var recordTime: Double = 20
    @State private var prepareTime: Double = 5
    @State private var testStatus: String = "Ready to Start"

    
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Speech to Text")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Transcribed Text:")
                    .font(.headline)
                    .padding(.top)
                
                ScrollView {
                    Text(transcribedText)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                }
                .padding()
                Spacer()
                
                Section(header: Text("History of Recordings")) {
                    List(audioRecorder.recordingList, id: \.self) { url in
                        HStack {
                            Text(url.lastPathComponent)
                            Button("Play") {
// how to add player method?
                            }
                        }
                    }
                }

                
                Spacer()
                
                Text("Status: \(testStatus)")
                    .font(.headline)
                    .padding()
                
                Spacer()
                
                if isRecording {
                    ProgressView(value: recordProgress, total: recordTime)
                        .padding()
                } else if isTranscribing {
                    ProgressView("Transcribing...")
                } else {
                    ProgressView(value: prepareProgress, total: prepareTime)
                        .padding()
                }
                
                Spacer()
                
                Button(isRecording ? "Stop Recording" : "Start Recording") {
                    if isRecording {
                        audioRecorder.stopRecording()
                        transcribeAudio()
                        isRecording.toggle()
                    } else {
                        startTimers()
//                        audioRecorder.startRecording()
                    }
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Time's Up"),
                          message: Text("Do you want to continue recording?"),
                          primaryButton: .default(Text("Yes")) {
                              startRecordTimer()
                          },
                          secondaryButton: .cancel(Text("No")) {
                              audioRecorder.stopRecording()
                          }
                    )
                }
            }
            .padding()
        }
    }


    func transcribeAudio() {
        isTranscribing = true
        let audioURL = audioRecorder.audioURL(for: testData.tests.first?.id ?? 1)
        
        let recognizer = SFSpeechRecognizer()
        let request = SFSpeechURLRecognitionRequest(url: audioURL)
        
        recognizer?.recognitionTask(with: request) { (result, error) in
            isTranscribing = false
            if let error = error {
                print("There was an error: \(error)")
            } else {
                transcribedText = result?.bestTranscription.formattedString ?? "Could not transcribe."
                if let firstTest = testData.tests.first {
                    print("Keywords for \(firstTest.name): \(firstTest.keywords)")
                }
            }
        }
    }
    
    func startTimers() {
        prepareProgress = 0
        recordProgress = 0
        testStatus = "Preparing to Test"

        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if self.prepareProgress < self.prepareTime {
                self.prepareProgress += 1
            } else {
                timer.invalidate()
                DispatchQueue.main.async {
                    self.isRecording = true
                    self.testStatus = "Recording Now"
                    self.audioRecorder.startRecording()  // Start recording here
                    self.startRecordTimer()
                }
            }
        }
    }

    func startRecordTimer() {
        testStatus = "Recording Now"
        
        let recordTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if recordProgress < recordTime {
                recordProgress += 1
            } else {
                timer.invalidate()
                DispatchQueue.main.async {
                    self.showAlert = true
                    self.testStatus = "Time is Up"
                }
            }
        }

        RunLoop.current.add(recordTimer, forMode: .common)
    }
}

#Preview {
    SpeechToTextView()
}
