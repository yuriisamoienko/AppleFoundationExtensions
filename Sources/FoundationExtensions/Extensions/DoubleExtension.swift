//
//  DoubleExtension.swift
//  FoundationExtensions
//
//  Created by Yurii Samoienko on 16.09.2021.
//

import Foundation

public extension Double {
    
    // MARK: Public Functions
    
    // Rounds the double to decimal places value
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        let result = (self * divisor).rounded() / divisor
        return result
    }
    
}
