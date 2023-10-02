//
//  imagesView.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/9/20.
//

import SwiftUI
import AVFoundation
import Speech
import UIKit

struct imagesView: View{
    @EnvironmentObject var audioRecorder: AudioRecord
    @State private var audioPlayer: AVAudioPlayer?
    @State private var player = Player()
    @State private var isPlaying = false
    @State private var shouldPlayNext = false
    
    let imageName: String
    let text: String
    @State private var currentSentenceIndex = 0
    @State private var timer: Timer? = nil
    @State private var showAlert = false
    @State private var isTextHidden = false
    @State private var currentPlay = -1
    @State private var rate: Float = 1.0
    @State private var playOption = 1
    
    
    var sentences: [String] {
        text.split(separator: ".").map { String($0) + "." }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollViewReader { scrollProxy in
                ScrollView {
                    VStack(alignment: .leading, spacing: 8) {
                        Image(imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .onTapGesture {
                                showAlert = true
                            }
                            .alert(isPresented: $showAlert) {
                                Alert(title: Text("答案展示"),
                                    message: Text("要选择看答案吗?"),
                                    primaryButton: .destructive(Text("是的")) {
                                    startTimer()
                                    isTextHidden = false
                                    for (index, sentence) in sentences.enumerated() {
                                        HuggingAPI.textToSpeech(sentence) { data, response, error in
                                            if let data = data {
                                                do {
                                                    try data.write(to: getDocumentsDirectory().appendingPathComponent("\(index).m4a"))
                                                } catch {
                                                    print("Unable to save file: \(error)")
                                                }
                                            } else if let error = error {
                                                print("Error: \(error)")
                                            }
                                        }
                                    }
                                },
                                secondaryButton: .cancel(Text("不要")) {
                                    isTextHidden = true
                                }
                            )
                        }
                        if !isTextHidden {
                            ForEach(0..<currentSentenceIndex, id: \.self) { index in
                                HStack {
                                    Button(action: {
                                        if isPlaying {
                                            player.pause()
                                            isPlaying = false
                                        } else {
                                            playAudioFile(index: index)
                                        }
                                    }) {
                                        Image(systemName: isPlaying && index == currentPlay ? "pause.circle" : "play.circle")
                                        .resizable() // Add this to be able to change the size of the image
                                        .frame(width: 40, height: 40) // Set the size of the image
                                    }
                                    
                                    SelectableText(text: sentences[index])
                                        .foregroundColor(index == currentPlay ? .blue : .primary)  // Change the color conditionally
                                        .animation(.easeInOut(duration: 1))
                                        .id(index)
                                }
                            }
                        }
                        Spacer(minLength: geometry.size.height * 0.5)
                    }
                    .padding(.horizontal, 35)
                    .padding(.top, 30)
                    .padding(.bottom, 80)
                    .onDisappear {
                        timer?.invalidate()
                    }
                    .onChange(of: currentSentenceIndex) { newValue in
                        withAnimation {
                            if newValue > 0 {
                                scrollProxy.scrollTo(newValue - 1, anchor: .bottom)
                            }
                        }
                    }
                }
                VStack {
                    HStack {
                        // Adding Picker here
                        Picker("Playback Option", selection: $playOption) {
                            Text("单句循环").tag(0)
                            Text("全部播放").tag(1)
                            Text("全部循环").tag(2)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding()
                        
                        Slider(value: $rate, in: 0.5...2.0, step: 0.1)
                            .padding(.horizontal)

                        Text("\(rate, specifier: "%.1f")x")
                            .frame(width: 40)
                        
                    }.padding(.horizontal)
                    
                    HStack {
                        RecorderAndPlayerView()
                    }
                }
            }
        }
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if currentSentenceIndex < sentences.count {
                withAnimation {
                    currentSentenceIndex += 1
                }
            } else {
                timer?.invalidate()
            }
        }
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
        
    private func playAudioFile(index: Int) {
        let url = getDocumentsDirectory().appendingPathComponent("\(index).m4a")
        player.rate = rate
        if isPlaying && currentPlay == index && !shouldPlayNext {
            player.pause()
            isPlaying = false
            shouldPlayNext = false
        } else if !isPlaying && currentPlay == index {
            player.play()
            isPlaying = true
            shouldPlayNext = false
        } else {
            player.playNext = {
                self.shouldPlayNext = true
                self.currentPlay += 1
                player.rate = rate
                if self.currentPlay >= self.sentences.count {
                    switch self.playOption {
                    case 0:
                        // Single Sentence Loop: keep playing the same sentence
                        self.currentPlay = index
                    case 1:
                        // Play All: stop after the last sentence
                        self.currentPlay = -1
                        self.shouldPlayNext = false
                        return
                    case 2:
                        // All Loops: restart from the first sentence if the last sentence has been played
                        self.currentPlay = 0
                    default:
                        self.shouldPlayNext = false
                        return
                    }
                }
                
                // Check self.playOption for every sentence play
                switch self.playOption {
                case 0:
                    // Single Sentence Loop: keep playing the same sentence
                    self.playAudioFile(index: index)
                case 1:
                    // Play All: stop after the last sentence
                    if self.currentPlay < self.sentences.count {
                        self.playAudioFile(index: self.currentPlay)
                    }
                case 2:
                    // All Loops: restart from the first sentence if the last sentence has been played
                    self.playAudioFile(index: self.currentPlay)
                default:
                    self.shouldPlayNext = false
                    return
                }
            }
            
            player.playAudioFile(url: url)
            isPlaying = true
            currentPlay = index
        }
    }
}

struct SelectableText: UIViewRepresentable {
    let text: String

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()

        textView.isEditable = false
        textView.isUserInteractionEnabled = true
        textView.isSelectable = true
        textView.text = text
        textView.font = UIFont.systemFont(ofSize: 30)

        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
}

struct imagesView_Previews: PreviewProvider {
    static var previews: some View {
        imagesView(imageName: "1", text: "Hello World The test is no longer than 2nd test. Hello, world.")
    }
}

