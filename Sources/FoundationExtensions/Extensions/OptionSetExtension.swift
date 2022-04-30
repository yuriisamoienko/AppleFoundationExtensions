//
//  OptionSetExtension.swift
//  FoundationExtensions
//
//  Created by Yurii Samoienko on 09.07.2021.
//

import Foundation

public extension OptionSet where RawValue: FixedWidthInteger {

    func elements() -> AnySequence<Self> {
        var remainingBits = rawValue
        var bitMask: RawValue = 1
        return AnySequence {
            return AnyIterator {
                while remainingBits != 0 {
                    defer { bitMask = bitMask &* 2 }
                    if remainingBits & bitMask != 0 {
                        remainingBits = remainingBits & ~bitMask
                        return Self(rawValue: bitMask)
                    }
                }
                return nil
            }
        }
    }
}
