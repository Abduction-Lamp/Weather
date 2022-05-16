//
//  DailyResponse.swift
//  Weather
//
//  Created by Владимир on 25.04.2022.
//

import Foundation

struct DailyResponse: Codable {
    let time: TimeInterval              // Время прогнозируемых данных, Unix, UTC
    let sunrise: TimeInterval           // Время восхода солнца, Unix, UTC
    let sunset: TimeInterval            // Время захода Солнца, Unix, UTC
    let moonrise: TimeInterval          // Время восхода Луны для данного дня, Unix, UTC
    let moonset: TimeInterval           // Время захода Луны в этот день, Unix, UTC
    let moonPhase: Double               // Фаза Луны: 0 и 1 - новолуние; 0,25 - первая четверть луны; 0,5 - полнолуние; 0,75 - последняя четверть луны"
    let temp: TempResponse              // Температура (по умолчанию: Кельвин, метрические: Цельсий, имперские: Фаренгейт)
    let feelsLike: FeelsLikeResponse    // Температура учитывающая человеческое восприятие погоды (по умолчанию: Кельвин)
    let pressure: Int                   // Атмосферное давление на уровне моря, гПа
    let humidity: Int                   // Влажность воздуха, %
    let dewPoint: Double                // Температура точки росы (по умолчанию: Кельвин)
    let windSpeed: Double               // Скорость ветра (по умолчанию: метры/сек, метрические: метры/сек, имперские: мили/час)
    let windGust: Double?               // Порыв ветра (по умолчанию: метр/сек, метрические: метр/сек, имперские: мили/час)
    let windDeg: Int                    // Направление ветра, градусы
    let uvi: Double                     // Максимальное значение УФ-индекса за день
    let clouds: Int                     // Облачность, %
    let pop: Double                     // Вероятность выпадения осадков
    let rain: Double?                   // Объем осадков, мм
    let snow: Double?                   // Объем снега, мм
    let weather: [WeatherResponse]      // Компоненты текущей погоды
    
    private enum CodingKeys: String, CodingKey {
        case time = "dt"
        case sunrise
        case sunset
        case moonrise
        case moonset
        case moonPhase = "moon_phase"
        case temp
        case feelsLike = "feels_like"
        case pressure
        case humidity
        case dewPoint = "dew_point"
        case windSpeed = "wind_speed"
        case windGust = "wind_gust"
        case windDeg = "wind_deg"
        case uvi
        case clouds
        case pop
        case rain
        case snow
        case weather
    }
}


extension DailyResponse: Equatable {
    
    static func == (lhs: DailyResponse, rhs: DailyResponse) -> Bool {
        lhs.time == rhs.time &&
        lhs.sunrise == rhs.sunrise &&
        lhs.sunset == rhs.sunset &&
        lhs.moonrise == rhs.moonrise &&
        lhs.moonset == rhs.moonset &&
        lhs.moonPhase == rhs.moonPhase &&
        lhs.temp == rhs.temp &&
        lhs.feelsLike == rhs.feelsLike &&
        lhs.pressure == rhs.pressure &&
        lhs.humidity == rhs.humidity &&
        lhs.dewPoint == rhs.dewPoint &&
        lhs.windSpeed == rhs.windSpeed &&
        lhs.windGust == rhs.windGust &&
        lhs.windDeg == rhs.windDeg &&
        lhs.uvi == rhs.uvi &&
        lhs.clouds == rhs.clouds &&
        lhs.pop == rhs.pop &&
        lhs.rain == rhs.rain &&
        lhs.snow == rhs.snow &&
        lhs.weather == rhs.weather
    }
}
