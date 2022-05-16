//
//  FakeURLSessionDataTask.swift
//  WeatherTests
//
//  Created by Владимир on 13.05.2022.
//

import Foundation
@testable import Weather

class FakeURLSessionDataTask: URLSessionDataTaskProtocol {
    
    private(set) var happened = false
    
    func resume() {
        happened = true
    }
}
