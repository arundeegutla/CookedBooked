//
//  DateFormatter.swift
//  BeRealClone
//
//  Created by CHENGTAO on 3/26/23.
//

import Foundation

/// Converts date from String type to Date format from
func formattedDate(dateString: String) -> Date? {
    let formatter = DateFormatter()
    formatter.dateFormat = "MM-dd-yyyy"
    return formatter.date(from: dateString)
}

extension DateFormatter {
    static var postFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
}
