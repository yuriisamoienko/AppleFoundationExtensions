//
//  NumberExtension.swift
//  FoundationExtensions
//
//  Created by Yurii Samoienko on 01.04.2021.
//

import Foundation

public extension Int {
    static func random(min: Int = 0, max: Int = Int.max, except: [Int] = []) -> Int {
        var result = random(in: min...max)
        if except.contains(result) {
            result = random(min: min, max: max, except: except)
        }
        return result
    }
    
    func isEven() -> Bool {
        let result = self % 2 == 0
        return result
    }

}

public extension Double {
    
    func stringPrecised(minimumPrecision: Int = 0, maximumPrecision: Int = 2) -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = minimumPrecision
        formatter.maximumFractionDigits = maximumPrecision //maximum digits in Double after dot (maximum precision)
        formatter.decimalSeparator = "."
        let result = String(formatter.string(from: number) ?? "")
        return result
    }
    
}
