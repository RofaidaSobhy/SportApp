//
//  DateUtils.swift
//  SportsApp
//
//  Created by Macos on 17/05/2025.
//

import Foundation

struct DateUtils {
    
    static func getFromDateOneYearAgo() -> String {
        return getFormattedDate(offsetYears: -1)
    }

    static func getToDateOneYearAhead() -> String {
        return getFormattedDate(offsetYears: 1)
    }

    private static func getFormattedDate(offsetYears: Int) -> String {
        let calendar = Calendar.current
        let currentDate = Date()
        if let adjustedDate = calendar.date(byAdding: .year, value: offsetYears, to: currentDate) {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter.string(from: adjustedDate)
        }
        return ""
    }
    
    
    static func toDate(from string: String, format: String = "yyyy-MM-dd") -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.date(from: string)
    }

    
}
