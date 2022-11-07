//
//  MockCityData.swift
//  WeatherTests
//
//  Created by Владимир on 05.10.2022.
//

import Foundation
@testable import Weather

class MockCityData {
    
    let raw:    [GeocodingResponse]
    let cities: [CityData]
    let data:   Data
    
    init() {
        typealias LocalNames = GeocodingResponse.LocalNames
        
        raw = [
            GeocodingResponse(name: "Moscow 1.0",
                              localNames: LocalNames(name: "Moscow 1.0", ascii: "Moscow 1.0", ru: "Москва 1.0", en: "Moscow 1.0"),
                              country: "RU",
                              state: "Moscow 1.0",
                              lat: 1.0,
                              lon: 1.0),
            
            GeocodingResponse(name: "Moscow 2.0",
                              localNames: LocalNames(name: "Moscow 2.0", ascii: "Moscow 2.0", ru: "Москва 2.0", en: "Moscow 2.0"),
                              country: "RU",
                              state: "Moscow 2.0",
                              lat: 2.0,
                              lon: 2.0),
                        
            GeocodingResponse(name: "Moscow 3.0",
                              localNames: LocalNames(name: "Moscow 3.0", ascii: "Moscow 3.0", ru: "Москва 3.0", en: "Moscow 3.0"),
                              country: "RU",
                              state: "Moscow 3.0",
                              lat: 3.0,
                              lon: 3.0)
        ]
        
        var list: [CityData] = []
        raw.forEach { list.append(CityData(geocoding: $0)) }
        cities = list
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        data = try! encoder.encode(raw)
    }
}
