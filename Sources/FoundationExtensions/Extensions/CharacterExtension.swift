//
//  CharacterExtension.swift
//  FoundationExtensions
//
//  Created by Yurii Samoienko on 12.07.2021.
//

import Foundation

public extension Character {
    
    func isEmoji() -> Bool {
        for scalar in unicodeScalars {
            if #available(iOS 10.2, *) {
                if scalar.properties.isEmoji == true { // introduced in Swift 5.0
                    return true
                }
            }
            let scalarValue = scalar.value
            switch scalarValue {
            case 0x1F600...0x1F64F, // Emoticons
                 0x1F300...0x1F5FF, // Misc Symbols and Pictographs
                 0x1F680...0x1F6FF, // Transport and Map
                 0x2600...0x26FF,   // Misc symbols
                 0x2700...0x27BF,   // Dingbats
                 0xFE00...0xFE0F,   // Variation Selectors
                 0x1F900...0x1F9FF, // Supplemental Symbols and Pictographs
                 129656...129758,
                 9193...9210,
                 127183...127569,
                 128992...129003,
                 0x1F1E6...0x1F1FF: // Flags
                return true
            default:
                continue
            }
        }
        return false
    }
    
}
