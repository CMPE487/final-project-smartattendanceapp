//
//  StringExtension.swift
//  AS-BaseProject
//
//  Created by Korhan Çağın Geboloğlu on 11.09.2018.
//  Copyright © 2018 Korhan Çağın Geboloğlu. All rights reserved.
//

import UIKit
extension String {
    func htmlAttributedString() -> NSAttributedString? {
        guard let data = self.data(using: String.Encoding.utf16, allowLossyConversion: false) else { return nil }
        guard let html = try? NSMutableAttributedString(
            data: data,
            options: [.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil) else { return nil }
        return html
    }
    func currencyInputFormatting() -> String {

        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.currencySymbol = ""
        formatter.currencyGroupingSeparator = "."
        formatter.currencyDecimalSeparator = ","
        var amountWithPrefix = self

        // remove from String: "$", ".", ","
        let regex = try? NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = (regex?.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSRange(location: 0, length: self.count), withTemplate: ""))!

        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 100))

        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return ""
        }

        return formatter.string(from: number)!
    }
    func formatDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = dateFormatter.date(from: self)!
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: date)
    }
    func formatDateTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = dateFormatter.date(from: self)!
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
        return dateFormatter.string(from: date)
    }

    func formatDateTimeSeconds() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = dateFormatter.date(from: self)!
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
        return dateFormatter.string(from: date)
    }

    func formatDate2() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from: self)!
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        return dateFormatter.string(from: date)
    }
    func formatDate(formatOfIncoming: String, formatOfDesired: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatOfIncoming
        let date = dateFormatter.date(from: self)!
        dateFormatter.dateFormat = formatOfDesired
        return dateFormatter.string(from: date)
    }
    func formatDate(formatOfIncoming: String, formatOfDesired: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatOfIncoming
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = formatOfDesired
            return dateFormatter.string(from: date)
        }
        return nil
    }
    func formatDate(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = dateFormatter.date(from: self)!
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    func contains(find: String) -> Bool {
        return self.range(of: find) != nil
    }

    func containsIgnoringCase(find: String) -> Bool {
        let locale = Locale.init(identifier: "tr_TR")
        let temp = self.lowercased(with: locale)
        return temp.range(of: find, options: .caseInsensitive) != nil

    }
    func createDate(format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        return date
    }
    func createDateWithShortStyle(format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        dateFormatter.dateStyle = .short
        return date
    }
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)

        return ceil(boundingBox.height)
    }

    func width(withConstraintedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)

        return ceil(boundingBox.width)
    }
}
