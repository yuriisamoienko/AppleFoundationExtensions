//
//  FileManagerExtension.swift
//  FoundationExtensions
//
//  Created by Yurii Samoienko on 30.04.2022.
//

import Foundation

@objc
public extension FileManager {
    
    static var documentDirectoryUrl: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
}
