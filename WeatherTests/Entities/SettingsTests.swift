//
//  SettingsTests.swift
//  WeatherTests
//
//  Created by Владимир on 17.05.2022.
//

import XCTest
@testable import Weather


class SettingsTests: XCTestCase {
    
    var expectation: XCTestExpectation!
    var settings: Settings!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        settings = Settings()
        expectation = XCTestExpectation(description: "[ Settings Unit-Test ]")
    }
    
    override func tearDownWithError() throws {
        settings = nil
        expectation = nil
        
        try super.tearDownWithError()
    }
}


// MARK: - Functional test case
//
extension SettingsTests {
    
    func testSettings() throws {
        XCTAssertNotNil(settings)
    }
    
    func testSettingsAdd_Success() throws {
        let list = MockCityData.init().cities
        
        list.forEach { city in
            let result = self.settings.add(city)
            XCTAssertTrue(result)
        }
        XCTAssertEqual(settings.cities.value, list)
    }
    
    func testSettingsAdd_Failure() throws {
        if let city = MockCityData.init().cities.first {
            var result = settings.add(city)
            XCTAssertTrue(result)
            result = settings.add(city)
            XCTAssertFalse(result)
        } else {
            XCTFail("Fail Test")
        }
    }
    
    func testSettingsRemove_Success() throws {
        let city1 = MockCityData.init().cities[0]
        let city2 = MockCityData.init().cities[1]
        let city3 = MockCityData.init().cities[2]
        
        let _ = settings.add(city1)
        let _ = settings.add(city2)
        let _ = settings.add(city3)
        XCTAssertEqual(settings.cities.value.count, 3)
        
        var city: CityData? = nil
        
        city = settings.remove(city: city1)
        XCTAssertEqual(city, city1)
        XCTAssertEqual(settings.cities.value.count, 2)
        
        city = settings.remove(city: city2)
        XCTAssertEqual(city, city2)
        XCTAssertEqual(settings.cities.value.count, 1)
        
        city = settings.remove(city: city3)
        XCTAssertEqual(city, city3)
        XCTAssertEqual(settings.cities.value.count, 0)
        
        city = settings.remove(city: city3)
        XCTAssertNil(city)
    }
    
    func testSettingsRemoveByIndex_Success() throws {
        let city1 = MockCityData.init().cities[0]
        let city2 = MockCityData.init().cities[1]
        let city3 = MockCityData.init().cities[2]
        
        let _ = settings.add(city1)
        let _ = settings.add(city2)
        let _ = settings.add(city3)
        XCTAssertEqual(settings.cities.value.count, 3)
        
        var city: CityData? = nil
        
        city = settings.remove(index: 2)
        XCTAssertEqual(city, city3)
        XCTAssertEqual(settings.cities.value.count, 2)
        
        city = settings.remove(index: 2)
        XCTAssertNil(city)
        XCTAssertEqual(settings.cities.value.count, 2)
    }
    
    func testSettingsMove_Success() throws {
        let city1 = MockCityData.init().cities[0]
        let city2 = MockCityData.init().cities[1]
        
        var result: Bool = false
        
        result = settings.add(city1)
        XCTAssertTrue(result)
        
        result = settings.add(city2)
        XCTAssertTrue(result)
        
        settings.move(at: 0, to: 1)
        XCTAssertEqual(settings.cities.value[0], city2)
        XCTAssertEqual(settings.cities.value[1], city1)
        
        settings.move(at: 3, to: 7)
        XCTAssertEqual(settings.cities.value[0], city2)
        XCTAssertEqual(settings.cities.value[1], city1)
        
        settings.move(at: 7, to: 7)
        XCTAssertEqual(settings.cities.value[0], city2)
        XCTAssertEqual(settings.cities.value[1], city1)
        
        settings.move(at: 0, to: 0)
        XCTAssertEqual(settings.cities.value[0], city2)
        XCTAssertEqual(settings.cities.value[1], city1)
    }
}
