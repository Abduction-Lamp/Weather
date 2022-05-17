//
//  FakeCities.swift
//  WeatherTests
//
//  Created by Владимир on 12.05.2022.
//

import Foundation
@testable import Weather



struct FakeCities  {
    
    let data: Data
    var citiesList: [CityData] = []
    let citiesRAW: [GeocodingResponse] = [
        GeocodingResponse(name: "Москва",
                          localNames: GeocodingResponse.LocalNames(featureName: "Moscow",
                                                                   ascii: "Москва",
                                                                   ru: "Москва",
                                                                   en: "Moscow"),
                          country: "RU",
                          state: nil,
                          lat: 1.0,
                          lon: 1.0),
        
        GeocodingResponse(name: "Москва1",
                          localNames: GeocodingResponse.LocalNames(featureName: "Moscow1",
                                                                   ascii: "Москва1",
                                                                   ru: "Москва1",
                                                                   en: "Moscow1"),
                          country: "RU",
                          state: nil,
                          lat: 2.0,
                          lon: 2.0),
        
        GeocodingResponse(name: "Москва3",
                          localNames: GeocodingResponse.LocalNames(featureName: "Moscow3",
                                                                   ascii: "Москва3",
                                                                   ru: "Москва3",
                                                                   en: "Moscow3"),
                          country: "RU",
                          state: nil,
                          lat: 3.0,
                          lon: 3.0),
        
        GeocodingResponse(name: "Москва4",
                          localNames: GeocodingResponse.LocalNames(featureName: "Moscow4",
                                                                   ascii: "Москва4",
                                                                   ru: "Москва4",
                                                                   en: "Moscow4"),
                          country: "RU",
                          state: nil,
                          lat: 4.0,
                          lon: 4.0),
        
        GeocodingResponse(name: "Москва5",
                          localNames: GeocodingResponse.LocalNames(featureName: "Moscow5",
                                                                   ascii: "Москва5",
                                                                   ru: "Москва5",
                                                                   en: "Moscow5"),
                          country: "RU",
                          state: nil,
                          lat: 5.0,
                          lon: 5.0)
    ]
    


    
    init() {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        data = try! encoder.encode(citiesRAW)
        
        citiesRAW.forEach { geo in
            citiesList.append(CityData(geocoding: geo))
        }
    }
}
