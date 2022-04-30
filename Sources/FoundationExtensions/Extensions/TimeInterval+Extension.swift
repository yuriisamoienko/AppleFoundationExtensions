//
//  TimeIntervalExtension.swift
//  FoundationExtensions
//
//  Created by Yurii Samoienko on 03.09.2021.
//

import Foundation

public extension TimeInterval {
    
    // MARK: Public Functions
    
    func format(using units: NSCalendar.Unit, unitsStyle: DateComponentsFormatter.UnitsStyle = .full) -> String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = units
        formatter.unitsStyle = unitsStyle
        formatter.zeroFormattingBehavior = .pad
        
        var calendar = Calendar.current
        calendar.locale = Localize.currentLocale
        formatter.calendar = calendar

        return formatter.string(from: self)
    }
    
}
