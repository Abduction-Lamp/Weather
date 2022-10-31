//
//  AirQualityIndexScalesTests.swift
//  WeatherTests
//
//  Created by Владимир on 31.10.2022.
//

import XCTest
@testable import Weather


class AirQualityIndexScalesTests: XCTestCase {
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    
    // MARK: - Europe Common Air Quality Index (CAQI)
    //
    //                                            NO2         O3          PM2.5       PM10
    // Good                                       0–50        0–60        0–15        0–25
    // Fair                                       50–100      60–120      15–30       25–50
    // Moderate                                   100–200     120–180     30–55       50–90
    // Poor                                       200–400     180–240     55–110      90–180
    // Very Poor                                  >400        >240        >110        >180
    //
    func testCAQIEuropeScale() throws {
        
        let arrGood:       [ChemicalElements] = [.no2(1),    .o3(1),    .pm2_5(1),    .pm10(1)]
        let arrFair:       [ChemicalElements] = [.no2(99),   .o3(119),  .pm2_5(29),   .pm10(49)]
        let arrModerate:   [ChemicalElements] = [.no2(100),  .o3(120),  .pm2_5(30),   .pm10(50)]
        let arrPoor:       [ChemicalElements] = [.no2(250),  .o3(200),  .pm2_5(100),  .pm10(100)]
        let arrVeryPoor:   [ChemicalElements] = [.no2(1000), .o3(1000), .pm2_5(1000), .pm10(1000)]
        
        let arrIndefinite: [ChemicalElements] = [.co(1), .no(1), .nh3(1), .so2(1), .no2(-1), .o3(-1), .pm2_5(-1), .pm10(-1)]
        
        
        arrGood.forEach { element in
            let aqi = CAQIEuropeScale.init(for: element)
            
            switch aqi {
            case .good:       XCTAssertEqual(aqi.rawValue, 1)
            case .fair:       XCTFail("Wrong branch (Fair)")
            case .moderate:   XCTFail("Wrong branch (Moderate)")
            case .poor:       XCTFail("Wrong branch (Poor)")
            case .veryPoor:   XCTFail("Wrong branch (Very Poor)")
            case .indefinite: XCTFail("Wrong branch (Indefinite)")
            }
        }

        arrFair.forEach { element in
            let aqi = CAQIEuropeScale.init(for: element)
            
            switch aqi {
            case .good:       XCTFail("Wrong branch (Good)")
            case .fair:       XCTAssertEqual(aqi.rawValue, 2)
            case .moderate:   XCTFail("Wrong branch (Moderate)")
            case .poor:       XCTFail("Wrong branch (Poor)")
            case .veryPoor:   XCTFail("Wrong branch (Very Poor)")
            case .indefinite: XCTFail("Wrong branch (Indefinite)")
            }
        }
        
        arrModerate.forEach { element in
            let aqi = CAQIEuropeScale.init(for: element)
            
            switch aqi {
            case .good:       XCTFail("Wrong branch (Good)")
            case .fair:       XCTFail("Wrong branch (Fair)")
            case .moderate:   XCTAssertEqual(aqi.rawValue, 3)
            case .poor:       XCTFail("Wrong branch (Poor)")
            case .veryPoor:   XCTFail("Wrong branch (Very Poor)")
            case .indefinite: XCTFail("Wrong branch (Indefinite)")
            }
        }
        
        arrPoor.forEach { element in
            let aqi = CAQIEuropeScale.init(for: element)
            
            switch aqi {
            case .good:       XCTFail("Wrong branch (Good)")
            case .fair:       XCTFail("Wrong branch (Fair)")
            case .moderate:   XCTFail("Wrong branch (Moderate)")
            case .poor:       XCTAssertEqual(aqi.rawValue, 4)
            case .veryPoor:   XCTFail("Wrong branch (Very Poor)")
            case .indefinite: XCTFail("Wrong branch (Indefinite)")
            }
        }
        
        arrVeryPoor.forEach { element in
            let aqi = CAQIEuropeScale.init(for: element)
            
            switch aqi {
            case .good:       XCTFail("Wrong branch (Good)")
            case .fair:       XCTFail("Wrong branch (Fair)")
            case .moderate:   XCTFail("Wrong branch (Moderate)")
            case .poor:       XCTFail("Wrong branch (Poor)")
            case .veryPoor:   XCTAssertEqual(aqi.rawValue, 5)
            case .indefinite: XCTFail("Wrong branch (Indefinite)")
            }
        }
        
        arrIndefinite.forEach { element in
            let aqi = CAQIEuropeScale.init(for: element)
            
            switch aqi {
            case .good:       XCTFail("Wrong branch (Good)")
            case .fair:       XCTFail("Wrong branch (Fair)")
            case .moderate:   XCTFail("Wrong branch (Moderate)")
            case .poor:       XCTFail("Wrong branch (Poor)")
            case .veryPoor:   XCTFail("Wrong branch (Very Poor)")
            case .indefinite: XCTAssertEqual(aqi.rawValue, 0)
            }
        }
    }
    
    
    // MARK: - India Air Quality Index (AQI)
    //
    //                 (Range)                      PM10         PM2.5        NO2          O3        CO         SO2        NH3
    //  Good           (0–50)                       0–50         0–30         0–40         0–50      0–1.0      0–40       0–200
    //  Satisfactory   (51–100)                     51–100       31–60        41–80        51–100    1.1–2.0    41–80      201–400
    //  Moderate       (101–200)                    101–250      61–90        81–180       101–168   2.1–10     81–380     401–800
    //  Poor           (201–300)                    251–350      91–120       181–280      169–208   10–17      381–800    801–1200
    //  Very Poor      (301–400)                    351–430      121–250      281–400      209–748   17–34      801–1600   1200–1800
    //  Severe         (401-500)                    430+         250+         400+         748+      34+        1600+      1800+
    //
    func testAQIIndiaScale() throws {
        
        let arrGood:         [ChemicalElements] = [.pm10(0),    .pm2_5(0),    .no2(0),    .o3(0),    .co(0),    .so2(0),    .nh3(0)]
        let arrSatisfactory: [ChemicalElements] = [.pm10(50),   .pm2_5(30),   .no2(40),   .o3(50),   .co(1),    .so2(40),   .nh3(200)]
        let arrModerate:     [ChemicalElements] = [.pm10(101),  .pm2_5(61),   .no2(81),   .o3(101),  .co(2),    .so2(81),   .nh3(401)]
        let arrPoor:         [ChemicalElements] = [.pm10(300),  .pm2_5(100),  .no2(200),  .o3(200),  .co(13),   .so2(700),  .nh3(1000)]
        let arrVeryPoor:     [ChemicalElements] = [.pm10(351),  .pm2_5(121),  .no2(281),  .o3(209),  .co(30),   .so2(1111), .nh3(1555)]
        let arrSevere:       [ChemicalElements] = [.pm10(2000), .pm2_5(2000), .no2(2000), .o3(2000), .co(2000), .so2(2000), .nh3(2000)]
        
        let arrIndefinite:   [ChemicalElements] = [.no(1), .pm10(-1), .pm2_5(-1), .no2(-1), .o3(-1), .co(-1), .so2(-1), .nh3(-1)]
        
        
        arrGood.forEach { element in
            let aqi = AQIIndiaScale.init(for: element)
            
            switch aqi {
            case .good:         XCTAssertEqual(aqi.rawValue, 1)
            case .satisfactory: XCTFail("Wrong branch (Satisfactory)")
            case .moderate:     XCTFail("Wrong branch (Moderate)")
            case .poor:         XCTFail("Wrong branch (Poor)")
            case .veryPoor:     XCTFail("Wrong branch (Very Poor)")
            case .severe:       XCTFail("Wrong branch (Severe)")
            case .indefinite:   XCTFail("Wrong branch (Indefinite)")
            }
        }

        arrSatisfactory.forEach { element in
            let aqi = AQIIndiaScale.init(for: element)
            
            switch aqi {
            case .good:         XCTFail("Wrong branch (Good)")
            case .satisfactory: XCTAssertEqual(aqi.rawValue, 2)
            case .moderate:     XCTFail("Wrong branch (Moderate)")
            case .poor:         XCTFail("Wrong branch (Poor)")
            case .veryPoor:     XCTFail("Wrong branch (Very Poor)")
            case .severe:       XCTFail("Wrong branch (Severe)")
            case .indefinite:   XCTFail("Wrong branch (Indefinite)")
            }
        }
        
        arrModerate.forEach { element in
            let aqi = AQIIndiaScale.init(for: element)
            
            switch aqi {
            case .good:         XCTFail("Wrong branch (Good)")
            case .satisfactory: XCTFail("Wrong branch (Satisfactory)")
            case .moderate:     XCTAssertEqual(aqi.rawValue, 3)
            case .poor:         XCTFail("Wrong branch (Poor)")
            case .veryPoor:     XCTFail("Wrong branch (Very Poor)")
            case .severe:       XCTFail("Wrong branch (Severe)")
            case .indefinite:   XCTFail("Wrong branch (Indefinite)")
            }
        }
        
        arrPoor.forEach { element in
            let aqi = AQIIndiaScale.init(for: element)
            
            switch aqi {
            case .good:         XCTFail("Wrong branch (Good)")
            case .satisfactory: XCTFail("Wrong branch (Satisfactory)")
            case .moderate:     XCTFail("Wrong branch (Moderate)")
            case .poor:         XCTAssertEqual(aqi.rawValue, 4)
            case .veryPoor:     XCTFail("Wrong branch (Very Poor)")
            case .severe:       XCTFail("Wrong branch (Severe)")
            case .indefinite:   XCTFail("Wrong branch (Indefinite)")
            }
        }
        
        arrVeryPoor.forEach { element in
            let aqi = AQIIndiaScale.init(for: element)
            
            switch aqi {
            case .good:         XCTFail("Wrong branch (Good)")
            case .satisfactory: XCTFail("Wrong branch (Satisfactory)")
            case .moderate:     XCTFail("Wrong branch (Moderate)")
            case .poor:         XCTFail("Wrong branch (Poor)")
            case .veryPoor:     XCTAssertEqual(aqi.rawValue, 5)
            case .severe:       XCTFail("Wrong branch (Severe)")
            case .indefinite:   XCTFail("Wrong branch (Indefinite)")
            }
        }
        
        arrSevere.forEach { element in
            let aqi = AQIIndiaScale.init(for: element)
            
            switch aqi {
            case .good:         XCTFail("Wrong branch (Good)")
            case .satisfactory: XCTFail("Wrong branch (Satisfactory)")
            case .moderate:     XCTFail("Wrong branch (Moderate)")
            case .poor:         XCTFail("Wrong branch (Poor)")
            case .veryPoor:     XCTFail("Wrong branch (Very Poor)")
            case .severe:       XCTAssertEqual(aqi.rawValue, 6)
            case .indefinite:   XCTFail("Wrong branch (Indefinite)")
            }
        }
        
        arrIndefinite.forEach { element in
            let aqi = AQIIndiaScale.init(for: element)
            
            switch aqi {
            case .good:         XCTFail("Wrong branch (Good)")
            case .satisfactory: XCTFail("Wrong branch (Satisfactory)")
            case .moderate:     XCTFail("Wrong branch (Moderate)")
            case .poor:         XCTFail("Wrong branch (Poor)")
            case .veryPoor:     XCTFail("Wrong branch (Very Poor)")
            case .severe:       XCTFail("Wrong branch (Severe)")
            case .indefinite:   XCTAssertEqual(aqi.rawValue, 0)
            }
        }
    }
    
    
    func testAQIIndiaScaleByInit() throws {

        XCTAssertEqual(AQIIndiaScale.init(aqi: 50), .good)
        XCTAssertEqual(AQIIndiaScale.init(aqi: 51), .satisfactory)
        XCTAssertEqual(AQIIndiaScale.init(aqi: 150), .moderate)
        XCTAssertEqual(AQIIndiaScale.init(aqi: 300), .poor)
        XCTAssertEqual(AQIIndiaScale.init(aqi: 301), .veryPoor)
        XCTAssertEqual(AQIIndiaScale.init(aqi: 500), .severe)
        
        XCTAssertEqual(AQIIndiaScale.init(aqi: -1), .indefinite)
        XCTAssertEqual(AQIIndiaScale.init(aqi: 1000), .indefinite)
    }
}
