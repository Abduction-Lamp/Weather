//
//  IntTests.swift
//  WeatherTests
//
//  Created by Владимир on 01.11.2022.
//

import XCTest
@testable import Weather

class IntTests: XCTestCase {

    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

//    func toRadians() -> CGFloat {
//        return CGFloat(Double.init(self) * Double.pi / 180.0)
//    }
//
//    func pressure(in unit: PressureUnits) -> Double {
//        switch unit {
//        case .mmHg:
//            let torr = 0.750064
//            return (torr * Double(self))
//        case .hPa:
//            return Double(self)
//        case .bar:
//            return 0.001 * Double(self)
//        }
//    }
//
//    func pressureToString(in unit: PressureUnits) -> String {
//        let measurements = pressure(in: unit)
//        switch unit {
//        case .mmHg:
//            return String(Int(measurements.rounded(.toNearestOrAwayFromZero)))
//        case .hPa:
//            return String(self)
//        case .bar:
//            return String(format: "%.3f", measurements)
//        }
//    }
    
    func testPressure() throws {
        let mmHg:     [Double] = [0, 1, 8, 75, 375, 675, 750, 762, 825, 900]
        let hPa:      [Double] = [0, 1, 10, 100, 500, 900, 1000, 1016, 1100, 1200]
        let bar:      [Double] = [0, 0.001, 0.01, 0.1, 0.5, 0.9, 1, 1.016, 1.1, 1.2]
        let pressure: [Int]    = [0, 1, 10, 100, 500, 900, 1000, 1016, 1100, 1200]

        
        if pressure.count == mmHg.count,
           pressure.count == hPa.count,
           pressure.count == bar.count {
            for index in 0 ..< pressure.count {
                XCTAssertEqual(mmHg[index], pressure[index].pressure(in: .mmHg))
                XCTAssertEqual(hPa[index], pressure[index].pressure(in: .hPa))
                XCTAssertEqual(bar[index], pressure[index].pressure(in: .bar))
            }
        } else {
            XCTFail("The sizes of the arrays being checked do not match")
        }
    }
    
    func testPressureToString() throws {
        let mmHg:     [String] = ["0", "1", "8", "75", "375", "675", "750", "762", "825", "900"]
        let hPa:      [String] = ["0", "1", "10", "100", "500", "900", "1000", "1016", "1100", "1200"]
        let bar:      [String] = ["0.000", "0.001", "0.010", "0.100", "0.500", "0.900", "1.000", "1.016", "1.100", "1.200"]
        let pressure: [Int]    = [0, 1, 10, 100, 500, 900, 1000, 1016, 1100, 1200]

        
        if pressure.count == mmHg.count,
           pressure.count == hPa.count,
           pressure.count == bar.count {
            for index in 0 ..< pressure.count {
                XCTAssertEqual(mmHg[index], pressure[index].pressureToString(in: .mmHg))
                XCTAssertEqual(hPa[index], pressure[index].pressureToString(in: .hPa))
                XCTAssertEqual(bar[index], pressure[index].pressureToString(in: .bar))
            }
        } else {
            XCTFail("The sizes of the arrays being checked do not match")
        }
    }
}
