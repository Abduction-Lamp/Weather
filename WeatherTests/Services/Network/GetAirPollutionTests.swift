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


extension GetAirPollutionTests {
    
    func testAirPollutionResponse_Equatable_() {
        // Equals
        var lhs = MockAirPollutionData.init().air
        let rhs = MockAirPollutionData.init().air
        XCTAssertTrue(lhs == rhs)
        
        
        // Does not  equals (Coordinates)
        let coord = AirPollutionResponse.CoordinatesResponse(lat: 0.0, lon: 1.0)
        var list = rhs.list
        lhs = AirPollutionResponse(coord: coord, list: list)
        XCTAssertFalse(lhs == rhs)
        
        
        // Does not  equals (List count)
        lhs = AirPollutionResponse(coord: rhs.coord, list: (list + list))
        XCTAssertFalse(lhs == rhs)
        
        
        // Does not  equals (List.time)
        let time = TimeInterval(123)
        list = [
            AirPollutionItemResponse(time: time,
                                     main: rhs.list.first!.main,
                                     components: rhs.list.first!.components)
        ]
        lhs = AirPollutionResponse(coord: rhs.coord, list: list)
        XCTAssertFalse(lhs == rhs)
        
        
        // Does not  equals (List.main)
        let main = AirPollutionItemResponse.AirQualityIndex(aqi: 5)
        list = [
            AirPollutionItemResponse(time: rhs.list.first!.time,
                                     main: main,
                                     components: rhs.list.first!.components)
        ]
        lhs = AirPollutionResponse(coord: rhs.coord, list: list)
        XCTAssertFalse(lhs == rhs)
        
        // Does not  equals (List.components)
        let components = AirPollutionItemResponse.AirComponents(co: nil, no: nil, no2: nil, o3: nil, so2: nil, pm2_5: nil, pm10: nil, nh3: nil)
        list = [
            AirPollutionItemResponse(time: rhs.list.first!.time,
                                     main: rhs.list.first!.main,
                                     components: components)
        ]
        lhs = AirPollutionResponse(coord: rhs.coord, list: list)
        XCTAssertFalse(lhs == rhs)
    }
}
