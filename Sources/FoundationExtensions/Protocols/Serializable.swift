//
//  Serializable.swift
//  Foundation Extensions
//
//  Created by Yurii Samoienko on 31.08.2020.
//

import Foundation

public protocol Serializable {
    func serialize() -> String?
    func serializeToData(_ options: JSONSerialization.WritingOptions) -> Data?
}

public extension Serializable {
    func serialize() -> String? {
        return serializeObject(self)
    }
    
    func serializeToData(_ options: JSONSerialization.WritingOptions = []) -> Data? {
        let obj = self
        var data: Data? = obj as? Data
        if data == nil {
            do {
                data = try JSONSerialization.data(withJSONObject: obj, options: options)
            } catch let parsingError {
                print("serializeToData parsingError: ", parsingError)
            }
        }

        return data
    }
}

extension Array: Serializable {}
extension Dictionary: Serializable {}

func serializeObject(_ object: Any?, options: JSONSerialization.WritingOptions = []) -> String? {
    guard let data = serializeToData(object, options: options) else { return nil }
    return String(data: data, encoding: String.Encoding.utf8)
}

func serializeToData(_ object: Any?, options: JSONSerialization.WritingOptions = []) -> Data? {
    guard let obj = object else { return nil }
    var data: Data? = object as? Data
    if data == nil {
        do {
            data = try JSONSerialization.data(withJSONObject: obj, options: options)
        } catch let parsingError {
            print("serializeToData parsingError: ", parsingError)
        }
    }

    return data
}
