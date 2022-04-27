//
//  CurrentResponse.swift
//  Weather
//
//  Created by Владимир on 25.04.2022.
//

import Foundation

struct CurrentResponse: Decodable {
    let time: TimeInterval          // Текущее время, Unix, UTC
    let sunrise: TimeInterval       // Время восхода солнца, Unix, UTC
    let sunset: TimeInterval        // Время захода солнца, Unix, UTC
    let temp: Double                // Температура (по умолчанию: Кельвин, метрические: Цельсий, имперские: Фаренгейт)
    let feelsLike: Double           // Температура учитывающая человеческое восприятие погоды (по умолчанию: Кельвин)
    let pressure: Int               // Атмосферное давление на уровне моря, гПа
    let humidity: Int               // Влажность воздуха, %
    let dewPoint: Double            // Температура точки росы (по умолчанию: Кельвин)
    let clouds: Int                 // Облачность, %
    let uvi: Double                 // Текущий УФ-индекс
    let visibility: Int             // Средняя видимость, метры
    let windSpeed: Double           // Скорость ветра (по умолчанию: метры/сек, метрические: метры/сек, имперские: мили/час)
    let windGust: Double?           // Порыв ветра (по умолчанию: метр/сек, метрические: метр/сек, имперские: мили/час)
    let windDeg: Int                // Направление ветра, градусы
    let rain: RainResponse?         // Количество осадков (дождь)
    let snow: SnowResponse?         // Количество осадков (снег)
    let weather: [WeatherResponse]  // Компоненты текущей погоды
    
    private enum CodingKeys: String, CodingKey {
        case time = "dt"
        case sunrise
        case sunset
        case temp
        case feelsLike = "feels_like"
        case pressure
        case humidity
        case dewPoint = "dew_point"
        case clouds
        case uvi
        case visibility
        case windSpeed = "wind_speed"
        case windGust = "wind_gust"
        case windDeg = "wind_deg"
        case rain
        case snow
        case weather
    }
}
