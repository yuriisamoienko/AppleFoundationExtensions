//
//  DataExtension.swift
//  FoundationExtensions
//
//  Created by Yurii Samoienko on 24.06.2021.
//

import Foundation

public extension Data {
    
    func append(fileURL: URL) throws {
        if let fileHandle = FileHandle(forWritingAtPath: fileURL.path) {
            defer {
                fileHandle.closeFile()
            }
            fileHandle.seekToEndOfFile()
            fileHandle.write(self)
        }
        else {
            try write(to: fileURL, options: .atomic)
        }
    }

    func toString() -> String {
        return String(decoding: self, as: UTF8.self)
    }
}
