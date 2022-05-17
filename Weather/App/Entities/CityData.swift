//
//  CityData.swift
//  Weather
//
//  Created by Владимир on 13.04.2022.
//

import Foundation

struct CityData: Codable {
    let eng: String
    let rus: String
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
}


extension CityData: Equatable {
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.eng == rhs.eng &&
        lhs.rus == rhs.rus &&
        lhs.latitude == rhs.latitude &&
        lhs.longitude == rhs.longitude
    }
}
