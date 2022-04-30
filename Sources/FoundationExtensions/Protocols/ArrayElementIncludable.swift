//
//  ArrayElementIncludable.swift
//  FoundationExtensions
//
//  Created by Yurii Samoienko on 02.08.2021.
//

import Foundation

public protocol ArrayElementIncludable: Equatable {}

public extension ArrayElementIncludable {
    
    func isIncluded(in array: [Self]) -> Bool {
        let result = array.contains(self)
        return result
    }
    
}

extension NSObject: ArrayElementIncludable {}
