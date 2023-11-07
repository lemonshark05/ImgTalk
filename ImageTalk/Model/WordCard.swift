//
//  WordCard.swift
//  ImageTalk
//
//  Created by lemonshark on 2023/11/5.
//

import Foundation

struct WordCard: Identifiable {
    let id = UUID()
    let word: String
    let explanation: String
    let synonyms: [String]
    let examples: [String]
}

class CSVParser {
    
    func loadCSV(contentsOfURL url: URL) -> [WordCard]? {
        do {
            let content = try String(contentsOf: url, encoding: .utf8)
            var rows = content.components(separatedBy: "\n")
            
            // Handle different newline characters that might be present in the CSV file
            if rows.count == 1 {
                rows = content.components(separatedBy: "\r\n")
            }
            
            var wordCards = [WordCard]()
            
            // Skip the first line as it is the header
            for row in rows.dropFirst() {
                let columns = row.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
                if columns.count >= 4 {
                    let wordCard = WordCard(
                        word: columns[0],
                        explanation: columns[1],
                        synonyms: columns[2].components(separatedBy: ";"),
                        examples: columns[3].components(separatedBy: ";")
                    )
                    wordCards.append(wordCard)
                }
            }
            
            return wordCards
        } catch {
            print("Error reading CSV: \(error)")
            return nil
        }
    }
}
