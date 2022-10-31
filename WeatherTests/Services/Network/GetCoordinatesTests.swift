//
//  GetCoordinatesTests.swift
//  WeatherTests
//
//  Created by Владимир on 06.10.2022.
//

import XCTest
@testable import Weather

class GetCoordinatesTests: XCTestCase {
    
    let timeout = TimeInterval(0.5)
    var expectation: XCTestExpectation!
    
    
    var mockURLs: MockURLs = MockURLs()
    var session: URLSessionProtocol = MockURLSession_Coordinates()
    
    var network: Network!
    
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        expectation = XCTestExpectation(description: "[ Network > Get Coordinates ]")
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
extension GetCoordinatesTests {
    
    func testNetwork() throws {
        XCTAssertNotNil(network)
    }
    
    func testGetCoordinates_Success() throws {
        let params = mockURLs.getCoordinates.urlExcitesData
        let cities = MockCityData()
        
        network?.getCoordinates(for: params.params, completed: { result in
            switch result {
            case .success(let list):
                XCTAssertEqual(list, cities.raw)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            self.expectation.fulfill()
        })
        wait(for: [self.expectation], timeout: timeout)
    }
    
    func testGetCoordinates_ResponseError() throws {
        let params = mockURLs.getCoordinates.urlExcitesResponseError
        var happened = false
        
        network?.getCoordinates(for: params.params, completed: { result in
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
    
    func testGetCoordinates_Error() throws {
        let params = mockURLs.getCoordinates.urlExcitesError
        var happened = false
        
        network?.getCoordinates(for: params.params, completed: { result in
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
    
    func testGetCoordinates_NilData() throws {
        let params = mockURLs.getCoordinates.urlExcitesNilData
        var happened = false
         
        network?.getCoordinates(for: params.params, completed: { result in
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
    
    func testGetCoordinates_DataDecodeError() throws {
        let params = mockURLs.getCoordinates.urlExcitesDecoderError
        var happened = false
         
        network?.getCoordinates(for: params.params, completed: { result in
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
