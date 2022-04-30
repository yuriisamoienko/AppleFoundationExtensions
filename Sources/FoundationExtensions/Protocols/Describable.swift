//
//  Describable.swift
//  FoundationExtensions
//
//  Created by Yurii Samoienko on 03.08.2021.
//

import Foundation

public protocol Describable {
    
    /// Retrieve the localized description for this error.
    var localizedDescription: String { get }
    
}
