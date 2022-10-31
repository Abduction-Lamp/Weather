//
//  MockURLs.swift
//  WeatherTests
//
//  Created by Владимир on 04.10.2022.
//

import Foundation
@testable import Weather

struct MockURLs {

    let getWeather = MockURLs.OneCall()
    let getCoordinates = MockURLs.Geocoding()
    let getAirPollution = MockURLs.AirPollution()
}


extension MockURLs {
    
    // MARK: OneCall
    //
    struct OneCall {
        typealias OneCallParams = (
            params: (lat: Double, lon: Double, units: String, lang: String),
            url: URL?
        )
        
        private static func makeParams(lat: Double, lon: Double, units: String, lang: String) -> OneCallParams {
            return (params: (lat: lat, lon: lon, units: units, lang: lang),
                    url: MockURLs.makeUrl(request: OneCallRequest(lat: lat, lon: lon, units: units, lang: lang)))
        }
        
        let urlExcitesData = makeParams(lat: 1.0, lon: 1.0, units: "metric", lang: "ru")
        let urlExcitesResponseError = makeParams(lat: 2.0, lon: 2.0, units: "metric", lang: "ru")
        let urlExcitesError = makeParams(lat: 3.0, lon: 3.0, units: "metric", lang: "ru")
        let urlExcitesDecoderError = makeParams(lat: 4.0, lon: 4.0, units: "metric", lang: "ru")
        let urlExcitesNilData = makeParams(lat: 5.0, lon: 5.0, units: "metric", lang: "ru")
    }
    
    
    // MARK: Geocoding
    //
    struct Geocoding {
        typealias GeocodingParams = (params: String, url: URL?)
        
        private static func makeParams(_ city: String) -> GeocodingParams {
            return (params: city,
                    url: MockURLs.makeUrl(request: GeocodingRequest(сity: city)))
        }
        
        let urlExcitesData = makeParams("Москва 1.0")
        let urlExcitesResponseError = makeParams("Москва 2.0")
        let urlExcitesError = makeParams("Москва 3.0")
        let urlExcitesDecoderError = makeParams("Москва 4.0")
        let urlExcitesNilData = makeParams("Москва 5.0")
    }
    
    
    // MARK: AirPollution
    //
    struct AirPollution {
        typealias AirPollutionParams = (params: (lat: Double, lon: Double),
                                        url: URL?)
        
        private static func makeParams(lat: Double, lon: Double) -> AirPollutionParams {
            return (params: (lat: lat, lon: lon),
                    url: MockURLs.makeUrl(request: AirPollutionRequest(lat: lat, lon: lon)))
        }
        
        let urlExcitesData = makeParams(lat: 1.0, lon: 1.0)
        let urlExcitesResponseError = makeParams(lat: 2.0, lon: 2.0)
        let urlExcitesError = makeParams(lat: 3.0, lon: 3.0)
        let urlExcitesDecoderError = makeParams(lat: 4.0, lon: 4.0)
        let urlExcitesNilData = makeParams(lat: 5.0, lon: 5.0)
    }
}


extension MockURLs {
    
    static func makeUrl(request: BaseRequest) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = request.scheme
        urlComponents.host = request.host
        urlComponents.path  = request.path
        urlComponents.queryItems = request.params
        return urlComponents.url
    }
}
