//
//  SKProductExtension.swift
//  FoundationExtensions
//
//  Created by Yurii Samoienko on 26.07.2021.
//

import Foundation
import StoreKit

public extension SKProduct {
    
    var localizedPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = priceLocale
        return formatter.string(from: price)!
    }
    
}
