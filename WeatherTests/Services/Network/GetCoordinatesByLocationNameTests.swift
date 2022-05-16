//
//  GetCoordinatesByLocationNameTests.swift
//  WeatherTests
//
//  Created by Владимир on 16.05.2022.
//

import Foundation

import XCTest
@testable import Weather


class GetCoordinatesByLocationNameTests: XCTestCase {
    
    var network: Network?
    var session: URLSessionProtocol = FakeURLSessionCoordinatesByLocationName()
    var fakeURLs: FakeURL = FakeURL()
    
    var expectation: XCTestExpectation!
    
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        network = Network(session: session)
        expectation = XCTestExpectation(description: "[ Network Unit-Test > GetCoordinatesByLocationName ]")
    }
    
    override func tearDownWithError() throws {
        network = nil
        expectation = nil
        try super.tearDownWithError()
    }
}


// MARK: - Network: GetCoordinatesByLocationName
//
extension GetCoordinatesByLocationNameTests {
    
    func testInitNetwork() throws {
        XCTAssertNotNil(network)
    }
    
    
    func testGetCoordinatesByLocationName_Success() throws {
        let expression = FakeCities()
        
        let city = fakeURLs.excitesData.getCoordinatesByLocationName
        
        network?.getCoordinatesByLocationName(city: city, completed: { result in
            switch result {
            case .success(let list):
                XCTAssertEqual(list, expression.cities)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            self.expectation.fulfill()
        })
        wait(for: [self.expectation], timeout: 1.0)
    }
    
    
    func testGetCoordinatesByLocationName_ResponseError() throws {
        var happened = false
        
        let city = fakeURLs.excitesResponseError.getCoordinatesByLocationName
         
        network?.getCoordinatesByLocationName(city: city, completed: { result in
            switch result {
            case .success(_):
                XCTFail("⚠️\tWrong branch (success)")
            case .failure(let error):
                switch error {
                case .error(_, _):
                    XCTFail("⚠️\tWrong branch (error)")
                case .status(url: let url, code: let code):
                    XCTAssertNotNil(url)
                    XCTAssertNotNil(code)
                    happened = true
                case .data(_, _):
                    XCTFail("⚠️\tWrong branch (data)")
                case .decode(_, _):
                    XCTFail("⚠️\tWrong branch (decode)")
                case .url(_):
                    XCTFail("⚠️\tWrong branch (url)")
                }
            }
            XCTAssertTrue(happened)
            self.expectation.fulfill()
        })
        wait(for: [self.expectation], timeout: 1.0)
    }
    
    
    func testGetCoordinatesByLocationName_Error() throws {
        var happened = false
        
        let city = fakeURLs.excitesError.getCoordinatesByLocationName
         
        network?.getCoordinatesByLocationName(city: city, completed: { result in
            switch result {
            case .success(_):
                XCTFail("⚠️\tWrong branch (success)")
            case .failure(let error):
                switch error {
                case .error(url: let url, message: let message):
                    XCTAssertNotNil(url)
                    XCTAssertNotNil(message)
                    happened = true
                case .status(_, _):
                    XCTFail("⚠️\tWrong branch (status)")
                case .data(_, _):
                    XCTFail("⚠️\tWrong branch (data)")
                case .decode(_, _):
                    XCTFail("⚠️\tWrong branch (decode)")
                case .url(_):
                    XCTFail("⚠️\tWrong branch (url)")
                }
            }
            XCTAssertTrue(happened)
            self.expectation.fulfill()
        })
        wait(for: [self.expectation], timeout: 1.0)
    }
    
    func testGetCoordinatesByLocationName_NilData() throws {
        var happened = false
        
        let city = fakeURLs.excitesNilData.getCoordinatesByLocationName
         
        network?.getCoordinatesByLocationName(city: city, completed: { result in
            switch result {
            case .success(_):
                XCTFail("⚠️\tWrong branch (success)")
            case .failure(let error):
                switch error {
                case .error(_, _):
                    XCTFail("⚠️\tWrong branch (error)")
                case .status(_, _):
                    XCTFail("⚠️\tWrong branch (status)")
                case .data(url: let url, message: let message):
                    XCTAssertNotNil(url)
                    XCTAssertNotNil(message)
                    happened = true
                case .decode(_, _):
                    XCTFail("⚠️\tWrong branch (decode)")
                case .url(_):
                    XCTFail("⚠️\tWrong branch (url)")
                }
            }
            XCTAssertTrue(happened)
            self.expectation.fulfill()
        })
        wait(for: [self.expectation], timeout: 1.0)
    }
    
    
    func testGetCoordinatesByLocationName_DataDecodeError() throws {
        var happened = false
        
        let city = fakeURLs.excitesDataDecoderError.getCoordinatesByLocationName
         
        network?.getCoordinatesByLocationName(city: city, completed: { result in
            switch result {
            case .success(_):
                XCTFail("⚠️\tWrong branch (success)")
            case .failure(let error):
                switch error {
                case .error(_, _):
                    XCTFail("⚠️\tWrong branch (error)")
                case .status(_, _):
                    XCTFail("⚠️\tWrong branch (status)")
                case .data(_, _):
                    XCTFail("⚠️\tWrong branch (data)")
                case .decode(url: let url, message: let message):
                    XCTAssertNotNil(url)
                    XCTAssertNotNil(message)
                    happened = true
                case .url(_):
                    XCTFail("⚠️\tWrong branch (url)")
                }
            }
            XCTAssertTrue(happened)
            self.expectation.fulfill()
        })
        wait(for: [self.expectation], timeout: 1.0)
    }
}
