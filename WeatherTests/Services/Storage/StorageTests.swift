//
//  StorageTests.swift
//  WeatherTests
//
//  Created by Владимир on 17.05.2022.
//

import XCTest
@testable import Weather


class StorageTests: XCTestCase {
    
    let storage = Storage()
    var settings: Settings?
    
    var expectation: XCTestExpectation!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        settings = Settings()
        initSettingsEntitie()
        expectation = XCTestExpectation(description: "[ Storage Unit-Test ]")
    }
    
    override func tearDownWithError() throws {
        settings = nil
        expectation = nil
        try super.tearDownWithError()
    }
    
    private func initSettingsEntitie() {
        settings?.cities.value = FakeCities().citiesList
        settings?.temperature.value = .kelvin
        settings?.pressure.value = .mmHg
        settings?.windSpeed.value = .mph
    }
}


extension StorageTests {
    
    func testInitStorage() throws {
        XCTAssertNotNil(storage)
        XCTAssertNotNil(settings)
    }
    
    
    func testStorageSave_Success() throws {
        if settings == nil {
            XCTFail("⚠️\tWrong settings == nil")
        }
        
        storage.save(settings!) { isSuccess in
            XCTAssertTrue(isSuccess)
            self.expectation.fulfill()
        }
        wait(for: [self.expectation], timeout: 1.0)
    }
    
    
    func testStorageFeatch_Success() throws {
        let expectation_save = XCTestExpectation(description: "[ Storage Unit-Test > Save ]")
        let expectation_featch = XCTestExpectation(description: "[ Storage Unit-Test > Featch ]")
        
        storage.save(settings!) { isSuccess in
            XCTAssertTrue(isSuccess)
            expectation_save.fulfill()
        }

        wait(for: [expectation_save], timeout: 1.0)
        
        storage.featch { response in
            switch response {
            case .success(let result):
                XCTAssertEqual(result, self.settings)
                expectation_featch.fulfill()
            case .failure(_):
                XCTFail("⚠️\tWrong branch (Error)")
                expectation_featch.fulfill()
            }
        }
        
        wait(for: [expectation_featch], timeout: 1.0)
    }
    
    
    func testStorageReset_Success() throws {
        let result = storage.reset()
        XCTAssertEqual(result, Settings())
    }
}
