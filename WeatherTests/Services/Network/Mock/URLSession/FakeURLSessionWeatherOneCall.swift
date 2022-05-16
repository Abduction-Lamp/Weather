//
//  FakeURLSessionWeatherOneCall.swift
//  WeatherTests
//
//  Created by Владимир on 13.05.2022.
//

import Foundation
@testable import Weather

class FakeURLSessionWeatherOneCall: URLSessionProtocol {
    
    let fakeURLs = FakeURL()
    
    func dataTaskEx(with url: URL,
                    completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        
        // MARK: - Success
        if fakeURLs.excitesData.absoluteString.contains(url.absoluteString) {
            let data = FakeWheather.init().data
            let response = HTTPURLResponse.init(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
            
            completionHandler(data, response, nil)
            return FakeURLSessionDataTask.init()
        }

        // MARK: - Failure Response
        if fakeURLs.excitesResponseError.absoluteString.contains(url.absoluteString) {
            let response = HTTPURLResponse.init(url: url, statusCode: 501, httpVersion: nil, headerFields: nil)
            
            completionHandler(nil, response, nil)
            return FakeURLSessionDataTask.init()
        }
        
        // MARK: - Failure Error
        if fakeURLs.excitesError.absoluteString.contains(url.absoluteString) {
            let error = NetworkResponseError.error(url: url.absoluteString, message: "error")
            
            completionHandler(nil, nil, error)
            return FakeURLSessionDataTask.init()
        }
        
        // MARK: - Failure Nil Data
        if fakeURLs.excitesNilData.absoluteString.contains(url.absoluteString) {
            let response = HTTPURLResponse.init(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
            
            completionHandler(nil, response, nil)
            return FakeURLSessionDataTask.init()
        }
        
        // MARK: - Failure Nil Data
        if fakeURLs.excitesDataDecoderError.absoluteString.contains(url.absoluteString) {
            let data = "{}".data(using: .utf8)
            let response = HTTPURLResponse.init(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
            
            completionHandler(data, response, nil)
            return FakeURLSessionDataTask.init()
        }
        
        
        completionHandler(nil, nil, nil)
        return FakeURLSessionDataTask.init()
    }
}
