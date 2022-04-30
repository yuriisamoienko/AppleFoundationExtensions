//
//  StringExtension.swift
//  FoundationExtensions
//
//  Created by Yurii Samoienko on 01.04.2021.
//

import Foundation

public extension String {
    
    var isNotEmpty: Bool {
        get {
            return isEmpty == false
        }
    }
    
    // returns nil is string is empty
    var notEmptyValue: String? {
        get {
            guard self.isNotEmpty == true else {
                return nil
            }
            return self
        }
    }
    
    init?(from: Any?) {
        guard let data = from else {
            return nil
        }
        if let val = data as? String {
            self = val
            return
        }
        if let val = data as? Int {
            self = String(val)
            return
        }
        if let val = data as? Double {
            self = String(val)
            return
        }
        return nil
    }
    
    func appendLineToURL(fileURL: URL) throws {
        try (self + "\n").appendToURL(fileURL: fileURL)
    }
    
    func appendToURL(fileURL: URL) throws {
        let data = self.data(using: String.Encoding.utf8)!
        try data.append(fileURL: fileURL)
    }
    
    mutating func replaceFirstOccurrence(of target: String, with replacement: String) {
        guard let range = self.range(of: target) else { return }
        self = replacingCharacters(in: range, with: replacement)
    }
    
    mutating func replace(value target: String, with replacement: String) {
        self = self.replacingOccurrences(of: target, with: replacement)
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    func substrings(byRegex regex: String) -> [String] {
        let text = self
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: text,
                                        range: NSRange(text.startIndex..., in: text))
            return results.map {
                String(text[Range($0.range, in: text)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    func substring(byRegex regex: String) -> String? {
        return substrings(byRegex: regex).first
    }
    
    func removingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
    
    func matchesRegex(_ regex: String) -> Bool {
        let result = self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
        return result
    }
    
    func withReplacing(value: String, with replacement: String) -> String {
        var str = self
        str.replace(value: value, with: replacement)
        return str
    }
    
    func withInserting(contentsOf value: String, at index: Index) -> String {
        var str = self
        str.insert(contentsOf: value, at: index)
        return str
    }
    
    init?(_ sequence: String.SubSequence?) {
        guard let value = sequence else {
            return nil
        }
        self.init(value)
    }
    
    static func randomOfLength(_ length: Int, from letters: String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789") -> String {
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    func withRemoving(byRegex regex: String) -> String {
        var result = self
        for item in self.substrings(byRegex: regex) {
            result = result.replacingOccurrences(of: item, with: "")
        }
        return result
    }
    
    func substring(to index: Int) -> Self {
        let result = (self as NSString).substring(to: index)
        return result
    }
    
    func substring(from index: Int) -> Self {
        let result = (self as NSString).substring(from: index)
        return result
    }
    
    func containsEmoji() -> Bool {
        var result = false
        for i in self {
            if i.isEmoji() {
                result = true
                break
            }
        }
        return result
    }
    
}
