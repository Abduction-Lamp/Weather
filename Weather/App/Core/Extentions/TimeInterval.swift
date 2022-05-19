//
//  InHours.swift
//  Weather
//
//  Created by Владимир on 19.05.2022.
//

import Foundation

extension TimeInterval {
    
    public func inHours() -> Int {
        return Int.init(self/60/60)
    }
    
    public func toStringLocolTime(offset: TimeInterval, format: String) -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.init(secondsFromGMT: offset.inHours())
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = format
            
        let date = Date(timeIntervalSince1970: self + offset)
        
        return formatter.string(from: date)
    }
}
