//
//  InHours.swift
//  Weather
//
//  Created by Владимир on 19.05.2022.
//

import Foundation

extension TimeInterval {
    
    ///
    /// Возвращает собственное значение в часы
    ///
    public func inHours() -> Int {
        return Int.init(self/60/60)
    }
    
    ///
    /// Возвращает строку содержащую время в указанном формате
    ///
    /// - Parameter offset: Часовой пояс выраженный в секундах
    /// - Parameter format: Формат, в котором будет выведено время
    ///
    /// - Note: Подробно о формате можно изучить на сайте `https://nsdateformatter.com/`
    ///
    public func toStringLocolTime(offset: TimeInterval, format: String) -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.init(secondsFromGMT: offset.inHours())
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = format
            
        let date = Date(timeIntervalSince1970: self + offset)
        
        return formatter.string(from: date)
    }
}
