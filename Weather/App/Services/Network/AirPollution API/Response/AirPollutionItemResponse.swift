//
//  AirPollutionItemResponse.swift
//  Weather
//
//  Created by Владимир on 18.10.2022.
//

import Foundation

struct AirPollutionItemResponse: Codable {
    
    let time: TimeInterval                   // Текущая дата и время, Unix, UTC
    let main: AirQualityIndex
    let components: AirComponents
    
    private enum CodingKeys: String, CodingKey {
        case time = "dt"
        case main
        case components
    }
    
    /// Индекс качества воздуха:
    ///
    /// - Parameter aqi: от 1 до 5
    ///     1 - Отичный
    ///     2 - Хороший
    ///     3 - Умеренный
    ///     4 - Загрезненный
    ///     5 - Опастный
    ///
    struct AirQualityIndex: Codable {
        let aqi: Int
        
        private enum CodingKeys: String, CodingKey {
            case aqi
        }
    }
    
    /// Компоненты по которым оценивается качество воздуха:
    ///
    /// - Parameter co:    Концентрация CO (Оксид углерода), мкг/м3
    /// - Parameter no:    Концентрация NO (Оксид азота), мкг/м3
    /// - Parameter no2:   Концентрация NO2 (Диоксида азота), мкг/м3
    /// - Parameter o3:    Концентрация О3 (Озон), мкг/м3
    /// - Parameter so2:   Концентрация SO2 (Диоксид серы), мкг/м3
    /// - Parameter pm2_5: Концентрация PM2.5 (Мелкие частицы), мкг/м3
    /// - Parameter pm10:  Концентрация PM10 (Крупные частицы), мкг/м3
    /// - Parameter nh3:   Концентрация NH3 (Аммиак), мкг/м3
    ///
    struct AirComponents: Codable {
        let co:    Double?
        let no:    Double?
        let no2:   Double?
        let o3:    Double?
        let so2:   Double?
        let pm2_5: Double?
        let pm10:  Double?
        let nh3:   Double?
        
        private enum CodingKeys: String, CodingKey {
            case co, no, no2, o3, so2, pm2_5, pm10, nh3
        }
    }
}


extension AirPollutionItemResponse: Equatable {
    
    static func == (lhs: AirPollutionItemResponse, rhs: AirPollutionItemResponse) -> Bool {
        lhs.time == rhs.time &&
        lhs.main.aqi == rhs.main.aqi &&
        lhs.components.co == rhs.components.co &&
        lhs.components.no == rhs.components.no &&
        lhs.components.no2 == rhs.components.no2 &&
        lhs.components.o3 == rhs.components.o3 &&
        lhs.components.so2 == rhs.components.so2 &&
        lhs.components.pm2_5 == rhs.components.pm2_5 &&
        lhs.components.pm10 == rhs.components.pm10 &&
        lhs.components.nh3 == rhs.components.nh3
    }
}
