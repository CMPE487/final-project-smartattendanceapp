//
//  DateExtension.swift
//  AS-BaseProject
//
//  Created by Korhan Çağın Geboloğlu on 11.09.2018.
//  Copyright © 2018 Korhan Çağın Geboloğlu. All rights reserved.
//

import Foundation
extension Date {
    /// This function creates a string version of date by using given format like yyyy.MM.dd
    func formatMaker(formatVersion: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "tr_TR")
        dateFormatter.dateFormat = formatVersion
        return dateFormatter.string(from: self)
    }
    /// This function adds seconds to self-date
    func add(seconds: Int) -> Date {
        return Calendar(identifier: .gregorian).date(byAdding: .second, value: seconds, to: self)!
    }

    /// This function adds minutes to self-date
    func add(minutes: Int) -> Date {
        return Calendar(identifier: .gregorian).date(byAdding: .minute, value: minutes, to: self)!
    }

    /// This function adds hours to self-date
    func add(hour: Int) -> Date {
        return Calendar(identifier: .gregorian).date(byAdding: .hour, value: hour, to: self)!
    }

    /// This function adds days to self-date
    func add(day: Int) -> Date {
        return Calendar(identifier: .gregorian).date(byAdding: .day, value: day, to: self)!
    }

    /// This function returns year of the self-date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }

    /// This function returns month of the self-date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }

    /// This function returns week of the self-date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }

    /// This function returns day of the self-date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }

    /// This function returns hour of the self-date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }

    /// This function returns minute of the self-date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }

    /// This function returns seconds of the self-date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
}
