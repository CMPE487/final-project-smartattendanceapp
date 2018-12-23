//
//  StringExtension.swift
//  RhExtranet
//
//  Created by Korhan Çağın Geboloğlu on 7.09.2018.
//  Copyright © 2018 AnadoluRH. All rights reserved.
//

import Foundation
extension Double {
    func convertTime() -> Double {
        return self/1000
    }
    func formatCurrencyWithTwoDigits(formatterStyle: NumberFormatter.Style) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = formatterStyle
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale(identifier: "tr_TR")
        let result = formatter.string(from: self as NSNumber)
        return result!
    }

    func formatCurrency(formatterStyle: NumberFormatter.Style, currency: String = "TL", maxDigits: Int = 2) -> String {
        let formatter = NumberFormatter()
        var sFormater = String()
        formatter.numberStyle = formatterStyle
        formatter.maximumFractionDigits = maxDigits
        if currency == "TL" {
            sFormater = "tr_TR"
        } else if currency == "USD" {
            sFormater = "en_US"
        } else if currency == "EUR" {
            sFormater = "es_ES"
        }
        formatter.locale = Locale(identifier: sFormater)
        let result = formatter.string(from: self as NSNumber)
        return result!
    }
}
