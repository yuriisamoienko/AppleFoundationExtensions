//
//  NSAttributedStringExtension.swift
//  FoundationExtensions
//
//  Created by Yurii Samoienko on 30.08.2021.
//

import Foundation

extension NSAttributedString {
    
    // concatenate attributed strings
    static func +(left: NSAttributedString, right: NSAttributedString) -> NSAttributedString {
        let result = NSMutableAttributedString()
        result.append(left)
        result.append(right)
        return result
    }

}
