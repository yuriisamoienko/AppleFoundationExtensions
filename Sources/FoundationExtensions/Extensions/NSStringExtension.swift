//
//  NSStringExtension.swift
//  FoundationExtensions
//
//  Created by Yurii Samoienko on 17.05.2021.
//

import Foundation

@objc
public extension NSString {
    
    @objc(fromInteger:)
    static func from(integer value: NSInteger) -> NSString {
        let result = NSString.init(format: "%ld", value)
        return result
    }
    
    @objc(withReplacing:with:)
    func withReplacing(value: String, with replacement: String) -> String {
        let str = self as String
        return str.withReplacing(value: value, with: replacement)
    }
    
    @objc(withInserting:at:)
    func withInserting(value: String, at index: Int) -> String {
        let str = self as String
        let charIndex = str.index(str.startIndex, offsetBy: index)
        return str.withInserting(contentsOf: value, at: charIndex)
    }
    
    func matchesRegex(_ regex: String) -> Bool {
        let str = self as String
        return str.matchesRegex(regex)
    }
    
    func substringByRegex(_ regex: String) -> String? {
        let str = self as String
        let result = str.substring(byRegex: regex)
        return result
    }
    
    func isEqualToAnyOfStrings(_ strings: [String]) -> Bool {
        var result = false
        for item in strings {
            guard self.isEqual(to: item) == true else { continue }
            result = true
            break
        }
        return result
    }
    
    static func isNotEmpty(_ string : String?) -> Bool {
        if let size = string?.count {
            if size > 0  {
                return true
            }
        }
        return false
    }
    
    
    static func isEmpty(_ string : String?) -> Bool {
        let result = self.isNotEmpty(string) == false
        return result
    }

}
