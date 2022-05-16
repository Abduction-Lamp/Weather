//
//  URLsExcitesResponseError.swift
//  WeatherTests
//
//  Created by Владимир on 16.05.2022.
//

import Foundation
@testable import Weather

struct URLsExcitesResponseError: FakeURLProtocol {
    
    var absoluteString: [String] = []
    
    let getWeatherOneCall: (lat: Double, lon: Double, units: String, lang: String)
    let getCoordinatesByLocationName: String
    
    
    init() {
        // MARK: -
        getWeatherOneCall = (lat: 2.0, lon: 2.0, units: "metric", lang: "ru")
        if let makeURLAbsoluteString = FakeURL.makeUrl(request: OneCallRequest(lat: getWeatherOneCall.lat,
                                                                               lon: getWeatherOneCall.lon,
                                                                               units: getWeatherOneCall.units,
                                                                               lang: getWeatherOneCall.lang)) {
            absoluteString.append(makeURLAbsoluteString.absoluteString)
        }
        
        // MARK: -
        getCoordinatesByLocationName = "Москва2"
        if let makeURLAbsoluteString = FakeURL.makeUrl(request: GeocodingRequest(сity: getCoordinatesByLocationName)) {
            absoluteString.append(makeURLAbsoluteString.absoluteString)
        }
    }
}
