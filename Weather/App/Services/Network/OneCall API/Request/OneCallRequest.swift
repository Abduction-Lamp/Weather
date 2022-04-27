//
//  OneCallRequest.swift
//  Weather
//
//  Created by Владимир on 25.04.2022.
//

import Foundation

struct OneCallRequest: BaseRequest {
    /// Abstruct
    let path: String = "/data/2.5/onecall"
    
    /// Request
    let lat: Double
    let lon: Double
    let units: String
    let lang: String

    /// exclude:
    /// С помощью этого параметра можно исключить некоторые части данных о погоде из ответа API
    /// Это должен быть список, разделенный запятыми (без пробелов)
    ///
    /// - Parameter current: Текущая погода
    /// - Parameter minutely: Поминутный прогноз (1 час)
    /// - Parameter hourly: Почасовой прогноз (48 часов)
    /// - Parameter daily: Прогноз на денелю (7 дней)
    /// - Parameter alerts: Национальные погодные предупреждения
    ///
    let exclude: String = "minutely"
    
    var params: [URLQueryItem] {
        return [
            URLQueryItem(name: "lat", value: "\(lat)"),
            URLQueryItem(name: "lon", value: "\(lon)"),
            URLQueryItem(name: "exclude", value: exclude),
            URLQueryItem(name: "units", value: units),
            URLQueryItem(name: "lang", value: lang),
            URLQueryItem(name: "appid", value: key)
        ]
    }
}
