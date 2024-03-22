//
//  GlobalMethods.swift
//  WT2024
//
//  Created by Jorge Silva on 21/03/2024.
//

import Foundation

func getDate(publishedAt: String) -> String {
    
    // https://sarunw.com/posts/how-to-parse-iso8601-date-in-swift/#iso-8601-with-fractional-seconds
    let formatter = ISO8601DateFormatter()
    formatter.formatOptions.insert(.withFractionalSeconds)
    let date = formatter.date(from: publishedAt)
    
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone(identifier: "UTC")
    dateFormatter.dateFormat = "dd-MMMM-yyyy"
    if let languageCode = Locale.current.language.languageCode {
        dateFormatter.locale = Locale(identifier: languageCode.identifier)
    }
    let published = dateFormatter.string(from: date!)

    return published
    
//        let ofString: String = " "+String(localized: "of")+" "
//        let newDate = published.replacingOccurrences(of: "-", with: ofString)
//
//        return newDate
}
