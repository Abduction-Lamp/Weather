//
//  MockURLSessionDataTask.swift
//  WeatherTests
//
//  Created by Владимир on 04.10.2022.
//

import Foundation
@testable import Weather

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    
    private(set) var happened = false
    
    func resume() {
        happened = true
    }
}
