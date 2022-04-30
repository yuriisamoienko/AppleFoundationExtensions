//
//  DateExtension.swift
//  FoundationExtensions
//
//  Created by Yurii Samoienko on 21.02.2020.
//

import Foundation

public extension Date {
    
    // MARK: Public Properties
    
    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: Localize.localeCode())
        return formatter
    }()

    var formatted: String {
        return Date.formatter.string(from: self)
    }

    func toString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: Localize.localeCode())
        let result = formatter.string(from: self)
        return result
    }

    func toStandartString() -> String {
        let result = toString(format: "yyyy-MM-dd HH:mm:ss")
        return result
    }

    static var yesterday: Date {
        return Date().dayBefore
    }

    static var tomorrow: Date {
        return Date().dayAfter
    }

    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }

    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    
    var dayOfMonth: Int {
        let result = get(component: .day)
        return result
    }

    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }

    var midnight: Date {
        return Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: self)!
    }

    var month: Int {
        return Calendar.current.component(.month, from: self)
    }

    var isLastDayOfMonth: Bool {
        return dayAfter.month != month
    }
    
    var hour: Int {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: self)
        return hour
    }

    var minute: Int {
        let calendar = Calendar.current
        let hour = calendar.component(.minute, from: self)
        return hour
    }
    
    // MARK: Constructors
    
    init(from str: String, dateFormat: String, locale: Locale, timeZone: TimeZone?) throws {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = locale
        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = dateFormat
        guard let date = dateFormatter.date(from: str) else {
            throw NSError(message: "date '\(str)' is not in format '\(dateFormat)")
        }
        self = date
    }

    // MARK: Public Functions

    func byAdding(minutes: Int) -> Date {
        return Calendar.current.date(byAdding: .minute, value: minutes, to: self)!
    }

    func byAdding(seconds: Int) -> Date {
        return Calendar.current.date(byAdding: .second, value: seconds, to: self)!
    }

    func byAdding(hours: Int) -> Date {
        return Calendar.current.date(byAdding: .hour, value: hours, to: self)!
    }

    func isToday() -> Bool {
        let today = Date().midnight
        let result = self.midnight == today
        return result
    }

    func isTomorrow() -> Bool {
        let tomorrow = Date.tomorrow.midnight
        let result = self.midnight == tomorrow
        return result
    }
    
    func toString(dataStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = dataStyle
        formatter.timeStyle = timeStyle
        formatter.locale = .current
        let result = formatter.string(from: self)
        return result
    }

    static func timeIntervalInDenmarkSince1970() -> Int? { //setCurrectTimezone
        let timestamp = NSDate().timeIntervalSince1970
        //Denmark is absent in TimeZone
        if let denmark = TimeZone(identifier: "Europe/Berlin") {
            let delta = TimeInterval(TimeZone.current.secondsFromGMT() - denmark.secondsFromGMT())
            let correctTimestamp = timestamp - delta
            let result = Int(correctTimestamp)
            return result
        }
        return nil
    }

    static func dateStringFromTimestamp(_ ts: Int) -> String { //dateFromTimestamp
        let date = Date(timeIntervalSince1970: TimeInterval(ts))

        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "MMM dd YYYY hh:mm a"

        return dayTimePeriodFormatter.string(from: date)
    }
    
    func get(components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }
    
    func get(component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }

}
