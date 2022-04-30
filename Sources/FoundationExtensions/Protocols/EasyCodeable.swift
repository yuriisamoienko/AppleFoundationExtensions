//
//  EasyCodeable.swift
//  FoundationExtensions
//
//  Created by Yurii Samoienko on 01.04.2021.
//

/*
 EasyCodable allows easily serialize & deserialize class & struct objects
 */

import Foundation

public protocol EasyCodable: Codable {
    associatedtype ClassType
    
    // override it to decode class object from a redunat json
    init(from dict: AnyDictionary) throws
}

extension Array: EasyCodable where Element: EasyCodable {
    
    static func decode(from arr: [AnyDictionary]) throws -> Self {
        var result: Self = []
        for item in arr {
            let data = try Element(from: item)
            result.append(data)
        }
        return result
    }
    
    func decode(from arr: [NSDictionary]) throws -> Self {
        var result: Self = []
        for item in arr {
            let data = try Element(from: item)
            result.append(data)
        }
        return result
    }
    
}

extension Dictionary: EasyCodable where Key: EasyCodable, Value: EasyCodable {}
extension String: EasyCodable {}

public typealias AnyDictionary = [AnyHashable: Any]

extension EasyCodable {
    public typealias ClassType = Self
    
    func encode() throws -> Data? {
        var result: Data?
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(self)
            result = data
        } catch {
            printFuncLog("\(String(describing: type(of: self))) failed to encode with error: \(error.localizedDescription)")
            throw error
        }
        return result
    }
    
    func encodeAsString() throws -> String? {
        var result: String?
        do {
            if let data = try self.encode(),
               let str = String(data: data, encoding: .utf8)
            {
                result = str
            }
        } catch {
        throw error
        }
        return result
    }
    
    // override it to decode class object from a redunat json
    public init(from dict: AnyDictionary) throws {
        let data = try dict.toData()
        self = try Self(data: data)
    }
    
    public init(from dict: NSDictionary) throws {
        let data = dict.toDictionary()
        self = try Self(from: data)
    }
    
    static func decode(from json: String?) throws -> Self? {
        guard let json = json else {
            return nil
        }
        return try Self(data: json)
    }
    
    public init(data json: String) throws {
        let data = Data(json.utf8)
        self = try Self(data: data)
    }
    
    static func decode(from data: Data?) throws -> Self? {
        guard let data = data else {
            return nil
        }
        let result = try Self(data: data)
        return result
    }
    
    init(data: Data) throws {
        let decoder = JSONDecoder()
        do {
            self = try decoder.decode(ClassType, from: data)
        } catch {
            printFuncLog("\(String(describing: type(of: Self.self))) failed to decode data: \(data) with error: \(error.localizedDescription)")
            throw error
        }
    }
    
}

public extension Data {
    
    func decodeToAny() throws -> Any {
        let result = try JSONSerialization.jsonObject(with: self, options: [])
        return result
    }
}
