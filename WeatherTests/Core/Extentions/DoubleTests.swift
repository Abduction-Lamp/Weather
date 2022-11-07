//
//  DoubleTests.swift
//  WeatherTests
//
//  Created by Владимир on 01.11.2022.
//

import XCTest
@testable import Weather

class DoubleTests: XCTestCase {

    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    
    func testToStringWithDegreeSymbol() throws {
        let expressionPlus = "+10\u{00B0}"
        let expressionMinus = "-10\u{00B0}"
        let expressionZero = "0\u{00B0}"
        
        var txt: Double = 10.0
        XCTAssertEqual(expressionPlus, txt.toStringWithDegreeSymbol())
        
        txt = 9.5
        XCTAssertEqual(expressionPlus, txt.toStringWithDegreeSymbol())
        
        txt = 10.49
        XCTAssertEqual(expressionPlus, txt.toStringWithDegreeSymbol())
        
        txt = -10.0
        XCTAssertEqual(expressionMinus, txt.toStringWithDegreeSymbol())
        
        txt = -9.5
        XCTAssertEqual(expressionMinus, txt.toStringWithDegreeSymbol())
        
        txt = -10.49
        XCTAssertEqual(expressionMinus, txt.toStringWithDegreeSymbol())
        
        txt = -0.0040000000000048885
        XCTAssertEqual(expressionZero, txt.toStringWithDegreeSymbol())
        
        txt = 0.0040000000000048885
        XCTAssertEqual(expressionZero, txt.toStringWithDegreeSymbol())
        
        txt = 0
        XCTAssertEqual(expressionZero, txt.toStringWithDegreeSymbol())
    }

    
    func testTemperature() throws {
        let celsius:     [Double] = [-50, -10,  -3,  -1,   0,   0,   0,   1,   3,   10,  50]
        let fahrenheit:  [Double] = [-58,  14,   26,  31,  32,  32,  32,  33,  38,  50,  122]
        let kelvin:      [Double] = [223,  263,  270, 272, 273, 273, 273, 274, 276, 283, 323]
        
        let temperature: [Double] = [-50, -10, -3.33, -0.7, -0.1, 0, 0.1, 0.7, 3.33, 10, 50]
        
        if temperature.count == celsius.count,
           temperature.count == fahrenheit.count,
           temperature.count == kelvin.count {
            
            for index in 0 ..< temperature.count {
                let celsiusRounded = temperature[index].toTemperature(in: .celsius).rounded(.toNearestOrAwayFromZero)
                let fahrenheitRounded = temperature[index].toTemperature(in: .fahrenheit).rounded(.toNearestOrAwayFromZero)
                let kelvinRounded = temperature[index].toTemperature(in: .kelvin).rounded(.toNearestOrAwayFromZero)
                
                XCTAssertEqual(celsius[index], celsiusRounded)
                XCTAssertEqual(fahrenheit[index], fahrenheitRounded)
                XCTAssertEqual(kelvin[index], kelvinRounded)
            }
        } else {
            XCTFail("The sizes of the arrays being checked do not match")
        }
    }
    
    
    func testWindSpeed() throws {
        let ms:    [Double] = [0, 0, 0, 1, 3, 10, 50]
        let kmh:   [Double] = [0, 0, 1, 3, 12, 36, 180]
        let mph:   [Double] = [0, 0, 0, 2, 7, 22, 112]
        
        let speed: [Double] = [0, 0.01, 0.2, 0.7, 3.33, 10, 50]
        
        if speed.count == ms.count,
           speed.count == kmh.count,
           speed.count == mph.count {
            for index in 0 ..< speed.count {
                let msToRounded = speed[index].toWindSpeed(in: .ms).rounded(.toNearestOrAwayFromZero)
                let kmhToRounded = speed[index].toWindSpeed(in: .kmh).rounded(.toNearestOrAwayFromZero)
                let mphToRounded = speed[index].toWindSpeed(in: .mph).rounded(.toNearestOrAwayFromZero)
                
                XCTAssertEqual(ms[index], msToRounded)
                XCTAssertEqual(kmh[index], kmhToRounded)
                XCTAssertEqual(mph[index], mphToRounded)
            }
        } else {
            XCTFail("The sizes of the arrays being checked do not match")
        }
    }
}
