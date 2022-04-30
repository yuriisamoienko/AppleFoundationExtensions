//
//  NSUserDefaultsExtension.swift
//  FoundationExtensions
//
//  Created by Yurii Samoienko on 04.06.2021.
//

import Foundation

@objc
public extension UserDefaults {
    
    func removeObjectsForKeys(_ keys: [String]) {
        for key in keys {
            removeObject(forKey: key)
        }
    }
    
    func reset() {
        let defaults = self
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }

}
