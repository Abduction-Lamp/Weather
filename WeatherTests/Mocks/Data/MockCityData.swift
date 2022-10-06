//
//  MockCityData.swift
//  WeatherTests
//
//  Created by Владимир on 05.10.2022.
//

import Foundation
@testable import Weather

class MockCityData {
    
    let raw: [GeocodingResponse]
    let cities: [CityData]
    let data: Data

    init() {
        typealias LocalNames = GeocodingResponse.LocalNames
        
        raw = [
            GeocodingResponse(name: "Москва 1.0",
                              localNames: LocalNames(featureName: "Moscow 1.0",
                                                     ascii: "Москва 1.0",
                                                     ru: "Москва 1.0",
                                                     en: "Moscow 1.0"),
                              country: "RU", state: nil,
                              lat: 1.0, lon: 1.0),
            
            GeocodingResponse(name: "Москва 2.0",
                              localNames: LocalNames(featureName: "Moscow 2.0",
                                                     ascii: "Москва 2.0",
                                                     ru: "Москва 2.0",
                                                     en: "Moscow 2.0"),
                              country: "RU", state: nil,
                              lat: 2.0, lon: 2.0),
            
            GeocodingResponse(name: "Москва 3.0",
                              localNames: LocalNames(featureName: "Moscow 3.0",
                                                     ascii: "Москва 3.0",
                                                     ru: "Москва 3.0",
                                                     en: "Moscow 3.0"),
                              country: "RU", state: nil,
                              lat: 3.0, lon: 3.0),
            
            GeocodingResponse(name: "Москва 4.0",
                              localNames: LocalNames(featureName: "Moscow 4.0",
                                                     ascii: "Москва 4.0",
                                                     ru: "Москва 4.0",
                                                     en: "Moscow 4.0"),
                              country: "RU", state: nil,
                              lat: 4.0, lon: 4.0),
            
            GeocodingResponse(name: "Москва 5.0",
                              localNames: LocalNames(featureName: "Moscow 5.0",
                                                     ascii: "Москва 5.0",
                                                     ru: "Москва 5.0",
                                                     en: "Moscow 5.0"),
                              country: "RU", state: nil,
                              lat: 5.0, lon: 5.0)
        ]
        
        var list: [CityData] = []
        raw.forEach { list.append(CityData(geocoding: $0)) }
        cities = list
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        data = try! encoder.encode(raw)
    }
}
