//
//  GetAirPollutionTests.swift
//  WeatherTests
//
//  Created by Владимир on 31.10.2022.
//

import XCTest
@testable import Weather

class GetAirPollutionTests: XCTestCase {

    let timeout = TimeInterval(0.5)
    var expectation: XCTestExpectation!
    
    var mockURLs: MockURLs = MockURLs()
    var session: URLSessionProtocol = MockURLSession_AirPollution()
    
    var network: Network!
    
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        expectation = XCTestExpectation(description: "[ Network > Get AirPollution ]")
        network = Network(session: session)
    }

    override func tearDownWithError() throws {
        expectation = nil
        network = nil
        
        try super.tearDownWithError()
    }
}


extension GetAirPollutionTests {
    
    func testNetwork() throws {
        XCTAssertNotNil(network)
    }
    
    func testGetAirPollution_Success() throws {
        let params = mockURLs.getAirPollution.urlExcitesData.params
        let air = MockAirPollutionData().air
        
        network?.getAirPollution(lat: params.lat, lon: params.lon, completed: { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response, air)
            case .failure(let error):
                XCTFail(error.description)
            }
            self.expectation.fulfill()
        })
        wait(for: [self.expectation], timeout: timeout)
    }
    
    func testGetAirPollution_ResponseError() throws {
        let params = mockURLs.getAirPollution.urlExcitesResponseError
        var happened = false
        
        network?.getAirPollution(lat: params.params.lat, lon: params.params.lon, completed: { result in
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
    
    func testGetAirPollution_Error() throws {
        let params = mockURLs.getAirPollution.urlExcitesError
        var happened = false
        
        network?.getAirPollution(lat: params.params.lat, lon: params.params.lon, completed: { result in
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
    
    func testGetAirPollution_NilData() throws {
        let params = mockURLs.getAirPollution.urlExcitesNilData
        var happened = false
        
        network?.getAirPollution(lat: params.params.lat, lon: params.params.lon, completed: { result in
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
    
    func testGetAirPollution_DataDecodeError() throws {
        let params = mockURLs.getAirPollution.urlExcitesDecoderError
        var happened = false
        
        network?.getAirPollution(lat: params.params.lat, lon: params.params.lon, completed: { result in
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
