//
//  HuggingAPI.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/9/20.
//

import Foundation

struct HuggingAPI {
    static let apiKey = "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"
    static let baseURL = "https://api-inference.huggingface.co/models/espnet/kan-bayashi_ljspeech_vits"
    
    static func textToSpeech(_ text: String, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        guard let url = URL(string: baseURL) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        let bodyData = ["inputs": text]
        request.httpBody = try? JSONSerialization.data(withJSONObject: bodyData, options: [])
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: completion)
        task.resume()
    }
}
struct WhisperAPI {
    static let apiKey = "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"
    static let baseURL = "https://api-inference.huggingface.co/models/openai/whisper-base"

    static func query(_ filePath: URL, completion: @escaping (Any?, URLResponse?, Error?) -> Void) {
        guard let url = URL(string: baseURL) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        // Read file data
        let fileData = try? Data(contentsOf: filePath)
        
        // Set body data
        request.httpBody = fileData
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                completion(nil, response, error)
                return
            }
            
            if let data = data {
                let jsonResult = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                completion(jsonResult, response, nil)
            }
        }
        task.resume()
    }
}


//struct WhisperAPI {
//    static let apiKey = "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"
//    static let baseURL = "https://api-inference.huggingface.co/models/openai/whisper-base"
//
//    static func query(_ filename: String, completion: @escaping (Any?, URLResponse?, Error?) -> Void) {
//        guard let url = URL(string: baseURL) else { return }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
//
//        // Read file data
//        let filePath = Bundle.main.path(forResource: filename, ofType: nil)!
//        let fileUrl = URL(fileURLWithPath: filePath)
//        let fileData = try? Data(contentsOf: fileUrl)
//
//        // Set body data
//        request.httpBody = fileData
//
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            guard error == nil else {
//                completion(nil, response, error)
//                return
//            }
//
//            if let data = data {
//                let jsonResult = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
//                completion(jsonResult, response, nil)
//            }
//        }
//        task.resume()
//    }
//}

