//
//  TestData.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/9/20.
//

import Foundation
import AVFoundation

class TestData: ObservableObject {
    @Published var tests: [Test]
    
    init() {
        do {
            let infoURL = Bundle.main.url(forResource: "info", withExtension: "txt") // Assuming info file is named "info.txt"
            let infoText = try String(contentsOf: infoURL!)
            let infoLines = infoText.components(separatedBy: .newlines)

            tests = infoLines.indices.compactMap { index in
                let line = infoLines[index]
                let components = line.components(separatedBy: ";")
                guard components.count == 3 else {
                    print("Invalid format at line \(index + 1)")
                    return nil
                }
                
                let name = components[0]
                let keywords = components[1].components(separatedBy: ", ")
                let info = components[2]
                let route = "\(index + 1)" // this is now just an image name, not a file path
                
                return Test(id: index + 1, name: name, info: info, keywords: keywords, imageRoute: route)
            }
        } catch {
            print("Error: \(error)")
            tests = []
        }
    }
}

struct Test: Identifiable {
    let id: Int
    let name: String
    let info: String
    let keywords: [String]
    let imageRoute: String
    
    init(id: Int, name: String, info: String, keywords: [String], imageRoute: String) {
        self.id = id
        self.name = name
        self.info = info
        self.keywords = keywords
        self.imageRoute = imageRoute
    }
}

class AudioRecord: ObservableObject {
    
    enum State {
        case idle
        case recording
        case doneRecording
    }

    enum PlaybackState {
        case stopped
        case playing
    }

    @Published var playbackState: PlaybackState = .stopped
    @Published var state: State = .idle

    private var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    var currentPictureIndex: Int = 1
    
    func audioURL(for index: Int) -> URL {
        getDocumentsDirectory()
            .appendingPathComponent("record")
            .appendingPathComponent("recording_\(index).m4a")
    }
    
    @Published var currentProgress: Double = 0
    var totalDuration: Double {
        return audioPlayer?.duration ?? 0
    }

    // Call this in a timer while the audio is playing
    func updateProgress() {
        currentProgress = audioPlayer?.currentTime ?? 0
    }

    // Call this when the slider changes its value
    func seek(to time: Double) {
        audioPlayer?.currentTime = time
    }

    func startRecording() {
        let recordDir = getDocumentsDirectory().appendingPathComponent("record")
        if !FileManager.default.fileExists(atPath: recordDir.path) {
            do {
                try FileManager.default.createDirectory(atPath: recordDir.path, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Couldn't create record directory")
            }
        }
        
        let recordingSession = AVAudioSession.sharedInstance()

        do {
            try recordingSession.setCategory(.record, mode: .default)
            try recordingSession.setActive(true)
        } catch {
            print("Failed to set up recording session")
        }

        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]

        do {
            audioRecorder = try AVAudioRecorder(url: audioURL(for: currentPictureIndex), settings: settings)
            audioRecorder.record()
            state = .recording
        } catch {
            print("Could not start recording")
        }
    }

    func stopRecording() {
        if audioRecorder != nil {
            audioRecorder.stop()
            state = .doneRecording
        }
    }

    func play() {
        if audioPlayer == nil {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: audioURL(for: currentPictureIndex))
            } catch {
                print("Could not load audio file")
                return
            }
        }
        
        if !audioPlayer.isPlaying {
            audioPlayer.play()
            playbackState = .playing
            startTimer()
        }
    }

    func stopPlayback() {
        audioPlayer.stop()
        playbackState = .stopped
        stopTimer()
    }

    private var timer: Timer?

    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            self?.updateProgress()
        }
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    var currentTimeString: String {
        let time = audioPlayer?.currentTime ?? 0
        return String(format: "%02d:%02d", Int(time) / 60, Int(time) % 60)
    }

    var totalDurationString: String {
        let time = audioPlayer?.duration ?? 0
        return String(format: "%02d:%02d", Int(time) / 60, Int(time) % 60)
    }

    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func pausePlayback() {
        audioPlayer.pause()
        playbackState = .stopped
        stopTimer()
    }
}

class Player: NSObject, AVAudioPlayerDelegate {
    var audioPlayer: AVAudioPlayer?
    var playNext: (() -> Void)?
    var rate: Float = 1.0

    func playAudioFile(url: URL) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.enableRate = true
            audioPlayer?.rate = rate
            audioPlayer?.delegate = self
            audioPlayer?.play()
        } catch {
            print("Failed to play audio: \(error)")
        }
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        playNext?()
    }
    
    func pause(){
        audioPlayer?.pause()
    }
    
    func play(){
        audioPlayer?.play()
    }
}
