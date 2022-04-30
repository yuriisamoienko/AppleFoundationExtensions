//
//  NSDictionaryExtension.swift
//  FoundationExtensions
//
//  Created by Yurii Samoienko on 17.05.2021.
//

import Foundation

@objc
public extension NSDictionary {
    
    @objc(integerForKey:defaultValue:)
    func integer(forKey key: NSObject?, defaultValue: NSInteger) -> NSInteger {
        let dictionary = self as Dictionary
        return dictionary.int(forKey: key) ?? defaultValue
    }
        
    @objc(stringForKey:defaultValue:)
    func string(forKey key: NSObject?, defaultValue: String) -> String {
        return string(forKey: key) ?? defaultValue
    }
    
    @objc(stringForKey:)
    func string(forKey key: NSObject?) -> String? {
        let dictionary = self as Dictionary
        return dictionary.string(forKey: key)
    }
    
    @objc(boolForKey:)
    func bool(forKey key: NSObject?) -> Bool {
        let dictionary = self as Dictionary
        return dictionary.bool(forKey: key) ?? false
    }
}

public extension NSDictionary {
    
    func toDictionary() -> AnyDictionary {
        return self as Dictionary as AnyDictionary
    }
    
    func string(for key: String) -> String? {
        let dictionary = self as Dictionary
        return dictionary.string(forKey: NSString(string: key))
    }
    
    func int(for key: String) -> Int? {
        let dictionary = self as Dictionary
        return dictionary.int(forKey: NSString(string: key))
    }
    
    func toStringAny() -> [String: Any] {
        var result: [String: Any] = [:]
        
        for key: Any in self.allKeys {
            if let stringKey = String(from: key),
                let keyValue = self.value(forKey: stringKey)
            {
                result[stringKey] = keyValue
            }
        }
        
        return result
    }

}


@objc
public extension NSMutableDictionary {
    
    @objc(setObject:forKeys:)
    func set(object: Value, for keys: [NSCopying]) {
        for key in keys {
            setObject(object, forKey: key)
        }
    }
}
