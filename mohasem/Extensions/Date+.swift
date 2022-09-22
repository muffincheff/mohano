//
//  Date+.swift
//  mohasem
//
//  Created by orca on 2022/09/06.
//

import Foundation

extension Date {
    // MARK: - Date format
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:SS"
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    var orderDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MMdd HH:mm"
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }

    var simpleDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd HH:mm"
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    var onlyDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    var onlyTimeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    public func toString() -> String {
        return dateFormatter.string(from: self as Date)
    }
    
    public func toSimpleString() -> String {
        return simpleDateFormatter.string(from: self as Date)
    }
    
    public func toOrderDateString() -> String {
        return orderDateFormatter.string(from: self as Date)
    }
    
    public func toOnlyDateString() -> String {
        return onlyDateFormatter.string(from: self as Date)
    }

    public func toOnlyTimeString() -> String {
        return onlyTimeFormatter.string(from: self as Date)
    }
}
