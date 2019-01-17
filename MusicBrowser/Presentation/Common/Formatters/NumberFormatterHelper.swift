//
//  NumberFormatterHelper.swift
//  MusicBrowser
//
//  Created by Guillermo Zafra on 17/01/2019.
//  Copyright © 2019 Guillermo Zafra. All rights reserved.
//

import Foundation

class NumberFormatterHelper {
    private static var currencyFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.roundingMode = .down
        return numberFormatter
    }()
    
    /// Formats a Double value to show as a currency value with provided symbol (suffix)
    static func format(rate: Double, currencySymbol: String) -> String {
        guard let stringValue = currencyFormatter.string(for: rate) else { return "#####" }
        return "\(stringValue) \(currencySymbol)"
    }
    
    static func format(length: TimeInterval) -> String {
        let minutes = Int((length/60).truncatingRemainder(dividingBy: 60))
        let seconds = Int(length.truncatingRemainder(dividingBy: 60))
        return String(format:"%d:%02d", minutes, seconds)
    }
}
