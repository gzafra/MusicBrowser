//
//  DateFormatterHelper.swift
//  MusicBrowser
//
//  Created by Guillermo Zafra on 17/01/2019.
//  Copyright © 2019 Guillermo Zafra. All rights reserved.
//

import Foundation

class DateFormatterHelper {
    private static var dateFormatter: DateFormatter = {
        var dateFormatter = DateFormatter()
        return dateFormatter
    }()
    
    /// Formats a given date in format (yyyy-MM-dd)
    static func formattedString(from date: Date) -> String {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    /// Formats a given date string to format (yyyy-MM-dd)
    static func formattedString(from dateString: String) -> String {
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = dateFormatter.date(from: dateString) {
            return formattedString(from: date)
        }else{
            return dateString
        }
    }
    
    /// Formats a given date in format (MM-dd)
    static func formattedShortString(from date: Date) -> String {
        dateFormatter.dateFormat = "MM-dd"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
}
