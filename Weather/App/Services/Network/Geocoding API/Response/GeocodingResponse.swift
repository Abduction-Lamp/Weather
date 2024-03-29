//
//  GeocodingResponse.swift
//  Weather
//
//  Created by Владимир on 25.04.2022.
//

import Foundation

struct GeocodingResponse: Codable {
    let name: String
    let localNames: LocalNames?
    let country: String
    let state: String?
    let lat: Double
    let lon: Double
    
    private enum CodingKeys: String, CodingKey {
        case name
        case localNames = "local_names"
        case country
        case state
        case lat
        case lon
    }
    
    
    struct LocalNames: Codable {
        let name: String?
        let ascii: String?
        let ru: String?
        let en: String?
        
        private enum CodingKeys: String, CodingKey {
            case name = "feature_name"
            case ascii
            case ru
            case en
        }
        
        /// Возвращает название города в зависимости от языка системы
        ///
        /// - Parameter lang: Язык выходных данных ["ru", "en", и др.]
        ///
        func getName(lang: String) -> String? {
            if lang == "ru" {
                return ru
            } else {
                return en
            }
        }
    }
}


extension GeocodingResponse: Equatable {
    
    static func == (lhs: GeocodingResponse, rhs: GeocodingResponse) -> Bool {
        lhs.name == rhs.name &&
        lhs.localNames == rhs.localNames &&
        lhs.country == rhs.country &&
        lhs.state == rhs.state &&
        lhs.lat == rhs.lat &&
        lhs.lon == rhs.lon
    }
}

extension GeocodingResponse.LocalNames: Equatable {
    
    static func == (lhs: GeocodingResponse.LocalNames, rhs: GeocodingResponse.LocalNames) -> Bool {
        lhs.ascii == rhs.ascii &&
        lhs.name == rhs.name &&
        lhs.ru == rhs.ru &&
        lhs.en == rhs.en
    }
}
