//
//  OneCellResponse.swift
//  Weather
//
//  Created by Владимир on 25.04.2022.
//

import Foundation

struct OneCallResponse: Decodable {
    let lat: Double                     // Географические координаты местоположения (широта)
    let lon: Double                     // Географические координаты местоположения (долгота)
    let timezone: String                // Название часового пояса для запрашиваемого местоположения
    let timezoneOffset: TimeInterval    // Сдвиг в секундах (UTC формат)
    let current: CurrentResponse?       // Текущая погода
    let minutely: [MinutelyResponse]?   // Поминутный прогноз погоды (1 час)
    let hourly: [HourlyResponse]?       // Почасовой прогноз погоды (48 часов)
    let daily: [DailyResponse]?         // Ежедневный прогноз погоды (7 дней)
    let alerts: [AlertsResponse]?       // Данные национальных метеорологических предупреждений
    
    private enum CodingKeys: String, CodingKey {
        case lat
        case lon
        case timezone
        case timezoneOffset = "timezone_offset"
        case current
        case minutely
        case hourly
        case daily
        case alerts
    }
}
