//
//  DateEx.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/29.
//

import Foundation

extension Date {
    func elTodayDate() -> String {
        let tofmt = DateFormatter()
        tofmt.dateFormat = "yyyy-MM-dd"
        tofmt.timeZone = TimeZone.current
        let string = tofmt.string(from: self)
        return string
    }
    
    func elTodayDateCN() -> String {
        let tofmt = DateFormatter()
        tofmt.dateFormat = "yyyy年MM月dd日"
        tofmt.timeZone = TimeZone.current
        let string = tofmt.string(from: self)
        return string
    }
    
    func momentTimeZero() -> String {
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd 00:00:00"
        fmt.timeZone = TimeZone.current
        let string = fmt.string(from: self)

        return string
    }
    
    func momentTimeEnd() -> String {
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd 23:59:59"
        fmt.timeZone = TimeZone.current
        let string = fmt.string(from: self)

        return string
    }
    
    func yesterday() -> Date {
        return self.addingRmoving(days: -1)
    }

    func addingRmoving(days: Int? = nil, months: Int? = nil, years: Int? = nil) -> Date {
        var calendar = NSCalendar.current
        calendar.timeZone = TimeZone.current
        var components = DateComponents()
        components.calendar = calendar
        if days != nil {
            components.day = days
        }
        if months != nil {
            components.month = months
        }
        if years != nil {
            components.year = years
        }
        return calendar.date(byAdding: components, to: self)!
    }

    static func previousDay(year: Int, month: Int, day: Int) -> Date {
        let date = Calendar.current.date(from: DateComponents(year: year, month: month, day: day))
        return date!.addingRmoving(days: -1)
    }

    static func nextDay(year: Int, month: Int, day: Int) -> Date {
        let date = Calendar.current.date(from: DateComponents(year: year, month: month, day: day))
        return date!.addingRmoving(days: 1)
    }

    static func previousMonth(year: Int, month: Int) -> Date {
        let date = Calendar.current.date(from: DateComponents(year: year, month: month))
        return date!.addingRmoving(months: -1)
    }

    static func nextMonth(year: Int, month: Int) -> Date {
        let date = Calendar.current.date(from: DateComponents(year: year, month: month))
        return date!.addingRmoving(months: 1)
    }

    static func previousQuarter(year: Int, month: Int) -> Date {
        let date = Calendar.current.date(from: DateComponents(year: year, month: month))
        return date!.addingRmoving(months: -3)
    }

    static func nextQuarter(year: Int, month: Int) -> Date {
        let date = Calendar.current.date(from: DateComponents(year: year, month: month))
        return date!.addingRmoving(months: 3)
    }

    static func previousAnnual(year: Int) -> Date {
        let date = Calendar.current.date(from: DateComponents(year: year))
        return date!.addingRmoving(years: -1)
    }

    static func nextAnnual(year: Int) -> Date {
        let date = Calendar.current.date(from: DateComponents(year: year))
        return date!.addingRmoving(years: 1)
    }

    static func getCurrentQuarter(month: Int) -> Int {
        var quarter = 0
        if month <= 3 {
            quarter = 1
        } else if month <= 6 {
            quarter = 2
        } else if month <= 9 {
            quarter = 3
        } else if month <= 12 {
            quarter = 4
        }
        return quarter
    }

    static func momentDate(_ dateStr: String) -> String {
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd"
        fmt.timeZone = TimeZone.current
        let date = fmt.date(from: dateStr)

        if date == nil {
            return dateStr
        }

        let tofmt = DateFormatter()
        tofmt.dateFormat = "yyyy年MM月dd日"
        tofmt.timeZone = TimeZone.current
        let string = tofmt.string(from: date!)

        return string
    }
    
    static func dateToUp(_ dateStr: String) -> String {
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy年MM月dd日"
        fmt.timeZone = TimeZone.current
        let date = fmt.date(from: dateStr)

        if date == nil {
            return dateStr
        }

        let tofmt = DateFormatter()
        tofmt.dateFormat = "yyyy-MM-dd"
        tofmt.timeZone = TimeZone.current
        let string = tofmt.string(from: date!)

        return string
    }
    
    static func momentTime(_ dateStr: String) -> String {
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd HH:mm:ss"
        fmt.timeZone = TimeZone.current
        let date = fmt.date(from: dateStr)

        if date == nil {
            return dateStr
        }

        let tofmt = DateFormatter()
        tofmt.dateFormat = "HH:ss"
        tofmt.timeZone = TimeZone.current
        let string = tofmt.string(from: date!)

        return string
    }

    static func todayDate() -> String {
        let tofmt = DateFormatter()
        tofmt.dateFormat = "yyyy-MM-dd"
        tofmt.timeZone = TimeZone.current
        let string = tofmt.string(from: Date())
        return string
    }

    static func todayDateCN() -> String {
        let tofmt = DateFormatter()
        tofmt.dateFormat = "yyyy年MM月dd日"
        tofmt.timeZone = TimeZone.current
        let string = tofmt.string(from: Date())
        return string
    }

    static func nowCN() -> String {
        let tofmt = DateFormatter()
        tofmt.dateFormat = "HH:ss"
        tofmt.timeZone = TimeZone.current
        let string = tofmt.string(from: Date())
        return string
    }

    static func normalDateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter
    }
    
    static func normalDateFormatter2() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }

}
