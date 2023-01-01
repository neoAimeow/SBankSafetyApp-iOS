//
//  BSDateComponent.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/11.
//

import Foundation
import UIKit

enum BSDateType {
    case year
    case month
    case day
    static var array: [BSDateType] {
        return [.year, .month, .day]
    }
}

public enum BSDateFormatType {
    case `default`
    case yearMonth
}

public struct BSDateComponent {
    public var year: Int = 0
    public var month: Int = 0
    public var day: Int = 0
    public var hour: Int = 0
    public var minute: Int = 0
    public var second: Int = 0
    
    public var date: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        return dateFormatter.date(from: "\(self.yearString)-\(self.monthString)-\(self.dayString) \(self.hourString):\(self.minuteString):\(self.secondString)")
    }
    
    public var week: Weekday? {
        guard let date = self.date else { return nil }
        let calendar = Calendar.current
        let week = (calendar as NSCalendar).components(.weekday, from: date).weekday ?? 0
        return Weekday.array[week - 1]
    }
    
    public var yearString: String {
        return "\(self.year)"
    }
    
    public var monthString: String {
        return self.month < 10 ? "0\(self.month)" : "\(self.month)"
    }
    
    public var dayString: String {
        return self.day < 10 ? "0\(self.day)" : "\(self.day)"
    }
    
    public var hourString: String {
        return self.hour < 10 ? "0\(self.hour)" : "\(self.hour)"
    }
    
    public var minuteString: String {
        return self.minute < 10 ? "0\(self.minute)" : "\(self.minute)"
    }
    
    public var secondString: String {
        return self.second < 10 ? "0\(self.second)" : "\(self.second)"
    }
    
    public init() { }
    
    mutating func reset() {
        self.year = 0
        self.month = 0
        self.day = 0
        self.hour = 0
        self.minute = 0
        self.second = 0
    }
    
    func equalYear(_ value: BSDateComponent?) -> Bool {
        guard let value = value else { return false }
        return self.year == value.year
    }
    
    func equalYearMonth(_ value: BSDateComponent?) -> Bool {
        guard let value = value else { return false }
        return self.year == value.year && self.month == value.month
    }
    
    func equalDate(_ value: BSDateComponent?) -> Bool {
        guard let value = value else { return false }
        return self.year == value.year && self.month == value.month && self.day == value.day
    }
    
    static func dateEqual(lhs: BSDateComponent, rhs: BSDateComponent) -> Bool {
        if lhs.year == rhs.year &&
            lhs.month == rhs.month &&
            lhs.day == rhs.day &&
            lhs.week == rhs.week &&
            lhs.yearString == rhs.yearString &&
            lhs.monthString == rhs.monthString &&
            lhs.dayString == rhs.dayString {
            return true
        } else {
            return false
        }
    }
    
    public static func ==(lhs: BSDateComponent, rhs: BSDateComponent) -> Bool {
        if lhs.year == rhs.year &&
            lhs.month == rhs.month &&
            lhs.day == rhs.day &&
            lhs.hour == rhs.hour &&
            lhs.minute == rhs.minute &&
            lhs.second == rhs.second {
            return true
        } else {
            return false
        }
    }
}

public extension BSDateComponent {
    enum Weekday {
        case monday, tuesday, wednesday, thursday, friday, saturday, sunday
        
        static var array: [Weekday] {
            return [.sunday, .monday, .tuesday, .wednesday, .thursday, .friday, .saturday]
        }
        
        public func valueShort() -> String {
            switch self {
            case .monday: return "一"
            case .tuesday: return "二"
            case .wednesday: return "三"
            case .thursday: return "四"
            case .friday: return "五"
            case .saturday: return "六"
            case .sunday: return "天"
            }
        }
        
        public func value() -> String {
            switch self {
            case .monday: return "星期一"
            case .tuesday: return "星期二"
            case .wednesday: return "星期三"
            case .thursday: return "星期四"
            case .friday: return "星期五"
            case .saturday: return "星期六"
            case .sunday: return "星期天"
            }
        }
        
        public static func ==(lhs: Weekday, rhs: Weekday) -> Bool {
            switch (lhs, rhs) {
            case (.monday, .monday): return true
            case (.tuesday, .tuesday): return true
            case (.wednesday, .wednesday): return true
            case (.thursday, .thursday): return true
            case (.friday, .friday): return true
            case (.saturday, .saturday): return true
            case (.sunday, .sunday): return true
            default: return false
            }
        }
    }
}

extension Date {
    var dateComponent: BSDateComponent {
        var component = BSDateComponent()
        let calendar = Calendar.current
        component.year = calendar.component(.year, from: self)
        component.month = calendar.component(.month, from: self)
        component.day = calendar.component(.day, from: self)
        component.hour = calendar.component(.hour, from: self)
        component.minute = calendar.component(.minute, from: self)
        component.second = calendar.component(.second, from: self)
        return component
    }
}
