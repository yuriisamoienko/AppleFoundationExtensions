//
//  CError.swift
//  FoundationExtensions
//
//  Created by Yurii Samoienko on 13.04.2021.
//

import Foundation

public class CError: NSObject {
    private var message: String?
    private lazy var userInfo: [String: Any] = [:]
    public private(set) var code: Int = 0
    
    convenience public init(message: String) {
        self.init()
        self.message = message
    }

    convenience public init(code: Int, message: String) {
        self.init(message: message)
    }
    
    convenience public init(data: [String: Any]?) {
        self.init(message: data?.description ?? "")
        if let _code = data?.int(forKey: "status") {
            self.code = _code
        }
    }
    
    public func userInfo(for key: String) -> Any? {
        let result = userInfo[key]
        return result
    }
}

extension CError: Error {}

extension CError: LocalizedError {
    public var errorDescription: String? {
        return message
    }
}

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


/*
public enum CErrorCode: UInt {
    case unknown
    case noInternetConnection
}

public class CError: NSObject {
    private var errorString: String?
    private lazy var values = DictionaryAny()
    
    convenience public init(_ value: String, properties: DictionaryAny? = nil) {
        self.init()
        errorString = value
        if let dict = properties {
            self.values = dict
        }
    }

    convenience public init(code: CErrorCode, properties: DictionaryAny? = nil) {
        var value = ""
        switch code {
        case .unknown:
            value = "unknown"
        case .noInternetConnection:
            value = "no_internet_connection_detected"
        }
        self.init(value)
        if let dict = properties {
            self.values = dict
        }
    }
    
    public func property(for key: String) -> Any? {
        let result = values[key]
        return result
    }
}

extension CError: Error {}

extension CError: LocalizedError {
    public var errorDescription: String? {
        return errorString?.localized
    }
}
*/
