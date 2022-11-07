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
            GeocodingResponse(name: "Moscow",
                              localNames: LocalNames(name: "Moscow", ascii: "Moscow", ru: "Москва", en: "Moscow"),
                              country: "RU",
                              state: "Moscow",
                              lat: 55.7504461,
                              lon: 37.6174943),
            
            GeocodingResponse(name: "London",
                              localNames: LocalNames(name: "London", ascii: "London", ru: "Лондон", en: "London"),
                              country: "GB",
                              state: "England",
                              lat: 51.5073219,
                              lon: -0.1276474),
                        
            GeocodingResponse(name: "New York County",
                              localNames: LocalNames(name: nil, ascii: nil, ru: "Нью-Йорк", en: "New York"),
                              country: "US",
                              state: "New York",
                              lat: 40.7127281,
                              lon: -74.0060152)
        ]
        
        var list: [CityData] = []
        raw.forEach { list.append(CityData(geocoding: $0)) }
        cities = list
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        data = try! encoder.encode(raw)
    }
}
