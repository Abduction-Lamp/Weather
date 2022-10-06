//
//  StorageTests.swift
//  WeatherTests
//
//  Created by Владимир on 17.05.2022.
//

import XCTest
@testable import Weather


class StorageTests: XCTestCase {

    let timeout: TimeInterval = 0.5
    
    var storage: Storage?
    var settings: Settings?
    
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        storage = Storage()
        settings = Settings()
        initSettingsEntitie()
    }
    
    override func tearDownWithError() throws {
        storage = nil
        settings = nil
        
        try super.tearDownWithError()
    }
    
    private func initSettingsEntitie() {        
        settings?.cities.value = MockCityData.init().cities
        settings?.units.value = Unit()
    }
}


// MARK: - Functional test case
//
extension StorageTests {
    
    func testSaveAndFeatch_Success() throws {
        guard let storage = storage else {
            XCTFail("Wrong storage == nil")
            return
        }
        guard let settings = settings else {
            XCTFail("Wrong settings == nil")
            return
        }
        
        let saveExpectation = XCTestExpectation(description: "[Save Expectation]: ")
        let featchExpectation = XCTestExpectation(description: "[Featch Expectation]: ")
        
    
        // MARK: Save
        storage.save(settings) { isSuccess in
            XCTAssertTrue(isSuccess)
            saveExpectation.fulfill()
        }
        wait(for: [saveExpectation], timeout: timeout)
        
        
        // MARK: Featch
        storage.featch { response in
            switch response {
            case .success(let result):
                XCTAssertEqual(result, self.settings)
                featchExpectation.fulfill()
            case .failure(_):
                XCTFail("Wrong branch (Error)")
                featchExpectation.fulfill()
            }
        }
        wait(for: [featchExpectation], timeout: timeout)
    }
    
    func testFeatch_Failure() throws {
        guard let storage = storage else {
            XCTFail("Wrong storage == nil")
            return
        }
        
        let featchExpectation = XCTestExpectation(description: "[Featch Expectation]: ")

        // MARK: Featch
        let _ = storage.reset()
        storage.featch { response in
            switch response {
            case .success:
                XCTFail("Wrong case == .success")
                featchExpectation.fulfill()
            case .failure(let result):
                XCTAssertEqual(result, .empty(source: "featch", message: "No data available"))
                featchExpectation.fulfill()
            }
        }
        wait(for: [featchExpectation], timeout: timeout)
    }
    
    
    func testReset_Success() throws {
        guard let storage = storage else {
            XCTFail("Wrong storage == nil")
            return
        }
        
        // MARK: Reset
        let result = storage.reset()
        XCTAssertEqual(result, Settings())
    }
}
