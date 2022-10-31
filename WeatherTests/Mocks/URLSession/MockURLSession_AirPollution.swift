//
//  MockURLSession_AirPollution.swift
//  WeatherTests
//
//  Created by Владимир on 31.10.2022.
//

import Foundation

@testable import Weather

class MockURLSession_AirPollution: URLSessionProtocol {

    private let mockURLs = MockURLs().getAirPollution
    
    func dataTaskEx(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        
        var data: Data? = nil
        var response: HTTPURLResponse? = nil
        var error: NetworkErrors? = nil
        
        switch url {
        // MARK: Success
        case mockURLs.urlExcitesData.url:
            error = nil
            response = HTTPURLResponse.init(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
            data = MockAirPollutionData.init().data

        // MARK: Failure Response (Response Error)
        case mockURLs.urlExcitesResponseError.url:
            error = nil
            response = HTTPURLResponse.init(url: url, statusCode: 501, httpVersion: nil, headerFields: nil)
            data = nil
            
        // MARK: Failure Error
        case mockURLs.urlExcitesError.url:
            error = NetworkErrors.error(url: url.absoluteString, message: "Error")
            response = nil
            data = nil
            
        // MARK: Failure Nil Data
        case mockURLs.urlExcitesNilData.url:
            error = nil
            response = HTTPURLResponse.init(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
            data = nil
            
        // MARK: Failure Data Decoder Error
        case mockURLs.urlExcitesDecoderError.url:
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