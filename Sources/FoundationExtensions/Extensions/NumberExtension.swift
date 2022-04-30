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

public extension CGFloat {
    func animate(to newValue: CGFloat,
                          duration: CGFloat,
                          onProgress: @escaping (CGFloat) -> Void,
                          onComplete: (() -> Void)? = nil) {
        let fps: Double = 60
        var value = self
        let compareBigger = newValue > self
        let step = (newValue - self)/CGFloat(fps)/duration
        Timer.scheduledTimer(withTimeInterval: 1/fps, repeats: true) { timer in
            value += step
            if compareBigger == true {
                if value > newValue {
                    value = newValue
                }
            } else {
                if value < newValue {
                    value = newValue
                }
            }
            onProgress(value)
            if value.isEqual(to: newValue) == true {
                timer.invalidate()
                onComplete?()
            }
        }
    }

    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
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
