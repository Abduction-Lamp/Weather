//
//  GetWeatherOneCallTests.swift
//  WeatherTests
//
//  Created by Владимир on 05.10.2022.
//

import XCTest
@testable import Weather

class GetWeatherOneCallTests: XCTestCase {
    
    let timeout = TimeInterval(0.5)
    var expectation: XCTestExpectation!
    
    
    var mockURLs: MockURLs = MockURLs()
    var session: URLSessionProtocol = MockURLSession_WeatherOneCall()
    
    var network: Network!
    
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        expectation = XCTestExpectation(description: "[ Network > WeatherOneCall ]")
        network = Network(session: session)
    }

    override func tearDownWithError() throws {
        expectation = nil
        network = nil
        
        try super.tearDownWithError()
    }
}


// MARK: - Functional test case
//
extension GetWeatherOneCallTests {
    
    func testNetwork() throws {
        XCTAssertNotNil(network)
    }
    
    func testGetWeatherOneCall_Success() throws {
        let params = mockURLs.getWeatherOneCall.urlExcitesData.params
        let weather = MockWeatherData().weather
        
        network?.getWeatherOneCall(lat: params.lat, lon: params.lon, completed: { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response, weather)
            case .failure(let error):
                XCTFail(error.description)
            }
            self.expectation.fulfill()
        })
        wait(for: [self.expectation], timeout: timeout)
    }
    
    func testGetWeatherOneCall_ResponseError() throws {
        let params = mockURLs.getWeatherOneCall.urlExcitesResponseError
        var happened = false
        
        network?.getWeatherOneCall(lat: params.params.lat, lon: params.params.lon, completed: { result in
            switch result {
            case .success(_):
                XCTFail("Wrong branch (success)")
            case .failure(let error):
                switch error {
                case .status(let url, let code):
                    XCTAssertEqual(url, params.url?.absoluteString)
                    XCTAssertEqual(code, 501)
                    happened = true
                case .error(_, _):
                    XCTFail("Wrong branch (error: error)")
                case .data(_, _):
                    XCTFail("Wrong branch (error: data)")
                case .decode(_, _):
                    XCTFail("Wrong branch (error: decode)")
                case .url(_):
                    XCTFail("Wrong branch (error: url)")
                }
            }
            XCTAssertTrue(happened)
            self.expectation.fulfill()
        })
        wait(for: [self.expectation], timeout: timeout)
    }
    
    func testGetWeatherOneCall_Error() throws {
        let params = mockURLs.getWeatherOneCall.urlExcitesError
        var happened = false
        
        network?.getWeatherOneCall(lat: params.params.lat, lon: params.params.lon, completed: { result in
            switch result {
            case .success(_):
                XCTFail("Wrong branch (success)")
            case .failure(let error):
                switch error {
                case .status(_, _):
                    XCTFail("Wrong branch (error: status)")
                case .error(let url, let message):
                    XCTAssertEqual(url, params.url?.absoluteString)
                    XCTAssertEqual(message, "Error")
                    happened = true
                case .data(_, _):
                    XCTFail("Wrong branch (error: data)")
                case .decode(_, _):
                    XCTFail("Wrong branch (error: decode)")
                case .url(_):
                    XCTFail("Wrong branch (error: url)")
                }
            }
            XCTAssertTrue(happened)
            self.expectation.fulfill()
        })
        wait(for: [self.expectation], timeout: timeout)
    }
    
    func testGetWeatherOneCall_NilData() throws {
        let params = mockURLs.getWeatherOneCall.urlExcitesNilData
        var happened = false
        
        network?.getWeatherOneCall(lat: params.params.lat, lon: params.params.lon, completed: { result in
            switch result {
            case .success(_):
                XCTFail("Wrong branch (success)")
            case .failure(let error):
                switch error {
                case .status(_, _):
                    XCTFail("Wrong branch (error: status)")
                case .error(_, _):
                    XCTFail("Wrong branch (error: error)")
                case .data(let url, let message):
                    XCTAssertEqual(url, params.url?.absoluteString)
                    XCTAssertEqual(message, "Data field is missing in the response.")
                    happened = true
                case .decode(_, _):
                    XCTFail("Wrong branch (error: decode)")
                case .url(_):
                    XCTFail("Wrong branch (error: url)")
                }
            }
            XCTAssertTrue(happened)
            self.expectation.fulfill()
        })
        wait(for: [self.expectation], timeout: timeout)
    }
    
    func testGetWeatherOneCall_DataDecodeError() throws {
        let params = mockURLs.getWeatherOneCall.urlExcitesDecoderError
        var happened = false
        
        network?.getWeatherOneCall(lat: params.params.lat, lon: params.params.lon, completed: { result in
            switch result {
            case .success(_):
                XCTFail("Wrong branch (success)")
            case .failure(let error):
                switch error {
                case .status(_, _):
                    XCTFail("Wrong branch (error: status)")
                case .error(_, _):
                    XCTFail("Wrong branch (error: error)")
                case .data(_, _):
                    XCTFail("Wrong branch (error: data)")
                case .decode(let url, let message):
                    XCTAssertEqual(url, params.url?.absoluteString)
                    XCTAssertEqual(message, "Data could not be decoded.")
                    happened = true
                case .url(_):
                    XCTFail("Wrong branch (error: url)")
                }
            }
            XCTAssertTrue(happened)
            self.expectation.fulfill()
        })
        wait(for: [self.expectation], timeout: timeout)
    }
}
