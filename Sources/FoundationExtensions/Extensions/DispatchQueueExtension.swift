//
//  DispatchQueueExtension.swift
//  FoundationExtensions
//
//  Created by Yurii Samoienko on 30.04.2017.
//

import Foundation

public extension DispatchQueue {
    
    static var background: DispatchQueue {
        return DispatchQueue.global(qos: .background)
    }
    
}
