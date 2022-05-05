//
//  NSErrorExtension.swift
//  
//
//  Created by Yurii Samoienko on 05.05.2022.
//

import Foundation

@objc
public extension NSError {
    
    var message: String? {
        get {
            let result = userInfo[NSLocalizedDescriptionKey] as? String
            return result
        }
    }
    
    convenience init(code: Int = 0, message: String) {
        self.init(domain: "", code: code, userInfo: [NSLocalizedDescriptionKey: message])
    }
    
    convenience init(message: String) {
        self.init(code: 0, message: message)
    }
    
    // usage: NSError(logMessage: "oops")
    convenience init(logMessage message: String, file: String = #file, line: UInt = #line, function: String = #function) {
        let log = funcLog(file: file, line: line, function: function)
        self.init(message: "\(log)\(message)")
    }
    
    // usage: NSError(logError: someError)
    convenience init(logError error: Error, file: String = #file, line: UInt = #line, function: String = #function) {
        self.init(logMessage: error.localizedDescription, file: file, line: line, function: function)
    }
    
    static func create(message: String) -> NSError {
        return NSError(message: message)
    }
    static func create(code: Int, message: String) -> NSError {
        return NSError(code: code, message: message)
    }

}

public extension NSError {
    
    convenience init(code: Int, userInfo: [String: Any]? = nil) {
        self.init(domain: "", code: 0, userInfo: userInfo)
    }
    
    convenience init(userInfo: [String: Any]? = nil) {
        self.init(code: 0, userInfo: userInfo)
    }

}
