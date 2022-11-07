//
//  MockURLSession_Network.swift
//  WeatherTests
//
//  Created by Владимир on 02.11.2022.
//

import Foundation
@testable import Weather

class MockURLSession_Network: URLSessionProtocol {
    
    private let getWeatherURLs = MockURLs().getWeather
    private let getAirURLs = MockURLs().getAirPollution
    private let getCoordinatesURLs = MockURLs().getCoordinates
    
    func dataTaskEx(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        
        var data: Data? = nil
        var response: HTTPURLResponse? = nil
        var error: NetworkErrors? = nil
        
        switch url {
        // MARK: Success for Weather
        case getWeatherURLs.urlExcitesData.url:
            error = nil
            response = HTTPURLResponse.init(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
            data = MockWeatherData.init().data

        // MARK: Success for Air
        case getAirURLs.urlExcitesData.url:
            error = nil
            response = HTTPURLResponse.init(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
            data = MockAirPollutionData.init().data
            
        // MARK: Success for Coordinates
        case getCoordinatesURLs.urlExcitesData.url:
            error = nil
            response = HTTPURLResponse.init(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
            data = MockCityData.init().data

         
        // MARK: -
        // MARK: Failure Response (Response Error)
        case
            getWeatherURLs.urlExcitesResponseError.url,
            getAirURLs.urlExcitesResponseError.url,
            getCoordinatesURLs.urlExcitesResponseError.url:
            error = nil
            response = HTTPURLResponse.init(url: url, statusCode: 501, httpVersion: nil, headerFields: nil)
            data = nil
            
        // MARK: Failure Error
        case
            getWeatherURLs.urlExcitesError.url,
            getAirURLs.urlExcitesError.url,
            getCoordinatesURLs.urlExcitesError.url:
            error = NetworkErrors.error(url: url.absoluteString, message: "Error")
            response = nil
            data = nil
            
        // MARK: Failure Nil Data
        case
            getWeatherURLs.urlExcitesNilData.url,
            getAirURLs.urlExcitesNilData.url,
            getCoordinatesURLs.urlExcitesNilData.url:
            error = nil
            response = HTTPURLResponse.init(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
            data = nil
            
        // MARK: Failure Data Decoder Error
        case
            getWeatherURLs.urlExcitesDecoderError.url, 
            getAirURLs.urlExcitesDecoderError.url,
            getCoordinatesURLs.urlExcitesDecoderError.url:
            error = nil
            response = HTTPURLResponse.init(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
            data = "{}".data(using: .utf8)
                        
        default:
            error = nil
            response = nil
            data = nil
        }
        
        completionHandler(data, response, error)
        return MockURLSessionDataTask.init()
    }
}
