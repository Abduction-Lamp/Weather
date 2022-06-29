//
//  CityData.swift
//  Weather
//
//  Created by Владимир on 13.04.2022.
//

import Foundation

struct CityData: Codable {
    private let eng: String
    private let rus: String
    let latitude: Double
    let longitude: Double
    
    init(eng: String, rus: String, latitude: Double, longitude: Double) {
        self.eng = eng
        self.rus = rus
        self.latitude = latitude
        self.longitude = longitude
    }
    
    init(geocoding: GeocodingResponse) {
        eng = geocoding.localNames?.en ?? geocoding.name
        rus = geocoding.localNames?.ru ?? geocoding.name
        latitude = geocoding.lat
        longitude = geocoding.lon
    }
    
    
    /// Возвращает название города в зависимости от языка системы
    ///
    /// - Parameter lang: Язык выходных данных ["ru", "en", и др.]
    ///
    func getName(lang: String) -> String {
        if lang == "ru" {
            return rus
        } else {
            return eng
        }
    }
}


extension CityData: Equatable {
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.eng == rhs.eng &&
        lhs.rus == rhs.rus &&
        lhs.latitude == rhs.latitude &&
        lhs.longitude == rhs.longitude
    }
}
