//
//  SKProductExtension.swift
//  FoundationExtensions
//
//  Created by Yurii Samoienko on 26.07.2021.
//

import Foundation
import StoreKit

@available(watchOS 6.2, iOS 3, macOS 10.7, tvOS 9.0, *)
public extension SKProduct {
    
    var localizedPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = priceLocale
        return formatter.string(from: price)!
    }
    
}
