//
//  DictionaryExtension.swift
//  FoundationExtensions
//
//  Created by Yurii Samoienko on 30.04.2022.
//

import Foundation

public typealias DictionaryAny = [String: Any]
public typealias DictionaryBool = [String: Bool]
public typealias DictionaryInt = [String: Int]
public typealias DictionaryUInt = [String: UInt]
public typealias DictionaryString = [String: String]

public extension Dictionary {
    
    func toJsonString() -> String? {
        var result: String?
        if let theJSONData = try? toData() {
            let theJSONText = String(data: theJSONData, encoding: .utf8)
            result = theJSONText
        }
        return result
    }
    
    func toData() throws -> Data {
        let result = try JSONSerialization.data(
            withJSONObject: self,
            options: []
        )
        return result
    }

    mutating func set(_ value: Value, for keys: [Key]) {
        for key in keys {
            self[key] = value
        }
    }
    
    static func += (left: inout [Key: Value], right: [Key: Value]) {
        for (k, v) in right {
            left[k] = v
        }
    }
    
    func double(forKey key: Key?) -> Double? {
        var result: Double?
        if let key = key {
            if let data = self[key] {
                if let value = data as? Double {
                    result = value
                } else if let str = data as? String,
                    let value = Double(str) {
                    result = value
                } else if let value = data as? Int {
                    result = Double(value)
                } else if let value = data as? Bool {
                    result = value ? 1: 0
                }
            }
        }
        return result
    }

    func int(forKey key: Key?) -> Int? {
        var result: Int?
        if let key = key {
            if let data = self[key] {
                if let value = data as? Int {
                    result = value
                } else if let str = data as? String,
                    let value = Int(str) {
                    result = value
                }
            }
        }
        return result
    }

    //usage double(forKey key: Key?, errorCode: Int)
    //errorCode is from scope of fatalMistake(..)
    func double(forKey: String, errorCode: Int, file: String = #file, line: UInt = #line, function: String = #function) throws -> Double {
        guard let key = forKey as? Key else {
            fatalErrorEx("can't get key as Dictionary.Key type")
        }
        guard let result = double(forKey: key) else {
            let message = generateErrorMessage(forKey: forKey, type: "Double")
            throw NSError(code: errorCode, message: message)
        }
        return result
    }

    //usage int(forKey key: Key?, errorCode: Int)
    //errorCode is from scope of fatalMistake(..)
    func int(forKey: String, errorCode: Int, file: String = #file, line: UInt = #line, function: String = #function) throws -> Int {
        guard let key = forKey as? Key else {
            fatalErrorEx("can't get key as Dictionary.Key type")
        }
        guard let result = int(forKey: key) else {
            let message = generateErrorMessage(forKey: forKey, type: "Double")
            throw NSError(code: errorCode, message: message)
        }
        return result
    }

    //usage string(forKey key: Key?, errorCode: Int)
    //errorCode is from scope of fatalMistake(..)
    func string(forKey: String, errorCode: Int, file: String = #file, line: UInt = #line, function: String = #function) throws -> String {
        guard let key = forKey as? Key else {
            fatalErrorEx("can't get key as Dictionary.Key type")
        }
        guard let value = self[key] else {
            throw NSError(message: "key '\(key) not found")
        }
        var result: String?
        if let str = value as? String {
            result = str
        } else if let number = value as? Int {
            let str = String(number)
            result = str
        } else if let number = value as? Double {
            let str = String(number)
            result = str
        }
        guard let output = result else {
            let message = generateErrorMessage(forKey: forKey, type: "Double")
            throw NSError(code: errorCode, message: message)
        }
        return output
    }
    
    func string(forKey key: Key?) -> String? {
        var result: String?
        if let key = key {
            if let data = self[key] {
                if let value = data as? Int {
                    result = String(value)
                } else if let str = data as? String {
                    result = str
                }
            }
        }
        return result
    }
    
    func bool(forKey key: Key?) -> Bool? {
        var result: Bool?
        if let key = key {
            if let data = self[key] {
                if let value = data as? Int {
                    result = value > 0
                } else if let value = data as? Bool {
                    result = value
                } else if let str = (data as? String)?.lowercased() {
                    if ["true", "yes"].contains(str) {
                        result = true
                    } else if ["false", "no"].contains(str) {
                        result = false
                    }
                }
            }
        }
        return result
    }

    fileprivate func generateErrorMessage(forKey key: String, type: String) -> String {
        let result = "can't get '\(key)' as \(type) from dictionary: \(self.serialize() ?? "<invalid>")"
        return result
    }

    func valuesArray() -> [Any] {
        let result = self.map { $0.1 }
        return result
    }
    
    init?(fromJson string: String) {
        guard let data = string.data(using: .utf8) else { return nil}
        do {
            if let value = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Self {
                self.init()
                self += value
                return
            }
        }
        catch {
            print (error)
        }
        return nil
    }
    
}

public extension Dictionary where Value: Equatable {
    
    func key(forValue value: Value) -> Key? {
        return first(where: { $1 == value })?.key
    }
    
}
