//
//  RecorderAndPlayer.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/9/22.
//

import SwiftUI
//import AVFoundation 

struct RecorderAndPlayerView: View {
    @ObservedObject var audioRecorder = AudioRecord()
    
    var body: some View {
        VStack {
            // Recording controls
            HStack {
                if audioRecorder.state == .idle || audioRecorder.state == .doneRecording {
                    Button(action: { self.audioRecorder.startRecording() }) {
                        Image(systemName: "circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .padding()
                            .foregroundColor(.blue)
                    }
                } else if audioRecorder.state == .recording {
                    Button(action: { self.audioRecorder.stopRecording() }) {
                        Image(systemName: "stop.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .padding()
                            .foregroundColor(.blue)
                    }
                }
            }
            
            if audioRecorder.state == .doneRecording {
                // Playback controls
                HStack {
                    // Volume control
                    HStack {
                        Image(systemName: "speaker.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding()
                        
                        Slider(value: Binding(get: {
                            self.audioRecorder.audioPlayer?.volume ?? 0.5
                        }, set: { (newValue) in
                            self.audioRecorder.audioPlayer?.volume = newValue
                        }), in: 0...1)
                        .accentColor(.blue)
                        .padding([.leading, .trailing])
                        
                        Image(systemName: "speaker.wave.3.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding()
                    }
                    
                    Button(action: {
                        // What's that? We're already jamming? Let's hit the brakes!
                        if self.audioRecorder.playbackState == .playing {
                            self.audioRecorder.pausePlayback()
                        } else {
                            // Silence? Not on my watch. Let's rock and roll!
                            self.audioRecorder.play()
                        }
                    }) {
                        // Here we're giving our button a quick wardrobe change - swapping between 'play' and 'pause' outfits on the fly
                        Image(systemName: self.audioRecorder.playbackState == .playing ? "pause.circle.fill" : "play.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .padding()
                            .foregroundColor(.green)
                    }

                    Slider(value: $audioRecorder.currentProgress, in: 0...audioRecorder.totalDuration, onEditingChanged: { _ in
                        self.audioRecorder.seek(to: audioRecorder.currentProgress)
                    })
                    .padding()
                    
                    // Current Time / Total Time
                    Text("\(audioRecorder.currentTimeString) / \(audioRecorder.totalDurationString)")
                }
            }
            // Transcription text
            Text("")
        }
    }
    
    
    func transcribeAudio() {
//        WhisperAPI.query(audioRecorder.audioURL(for: audioRecorder.currentPictureIndex)) { (result, response, error) in
//            if let error = error {
//                print("Error: \(error)")
//            } else if let result = result as? [String: Any],
//                      let transcription = result["transcription"] as? String {
//                DispatchQueue.main.async {
//
//                }
//            }
//        }
    }
}

struct RecorderAndPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        RecorderAndPlayerView()
    }
}

