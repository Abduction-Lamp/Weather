//
//  HourlyResponse.swift
//  Weather
//
//  Created by Владимир on 25.04.2022.
//

import Foundation

struct HourlyResponse: Decodable {
    let time: TimeInterval          // Время прогнозируемых данных, Unix, UTC
    let temp: Double                // Температура (по умолчанию: Кельвин, метрические: Цельсий, имперские: Фаренгейт)
    let feelsLike: Double           // Температура учитывающая человеческое восприятие погоды (по умолчанию: Кельвин)
    let pressure: Int               // Атмосферное давление на уровне моря, гПа
    let humidity: Int               // Влажность воздуха, %
    let dewPoint: Double            // Температура точки росы (по умолчанию: Кельвин)
    let uvi: Double                 // Текущий УФ-индекс
    let clouds: Int                 // Облачность, %
    let visibility: Int             // Средняя видимость, метры
    let windSpeed: Double           // Скорость ветра (по умолчанию: метры/сек, метрические: метры/сек, имперские: мили/час)
    let windGust: Double?           // Порыв ветра (по умолчанию: метр/сек, метрические: метр/сек, имперские: мили/час)
    let windDeg: Int                // Направление ветра, градусы
    let pop: Double                 // Вероятность выпадения осадков
    let rain: RainResponse?         // Количество осадков (дождь)
    let snow: SnowResponse?         // Количество осадков (снег)
    let weather: [WeatherResponse]  // Компоненты текущей погоды
    
    private enum CodingKeys: String, CodingKey {
        case time = "dt"
        case temp
        case feelsLike = "feels_like"
        case pressure
        case humidity
        case dewPoint = "dew_point"
        case uvi
        case clouds
        case visibility
        case windSpeed = "wind_speed"
        case windGust = "wind_gust"
        case windDeg = "wind_deg"
        case pop
        case rain
        case snow
        case weather
    }
}
