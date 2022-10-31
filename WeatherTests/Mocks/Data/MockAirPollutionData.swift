//
//  MockAirPollutionData.swift
//  WeatherTests
//
//  Created by Владимир on 31.10.2022.
//

import Foundation
@testable import Weather

class MockAirPollutionData {

    let air: AirPollutionResponse
    let data: Data
    
    init() {
        let builder = BuilderMockAirPollutionResponse()
        let coord = AirPollutionResponse.CoordinatesResponse(lat: 37.6156, lon: 55.7522)
        let list = [
            AirPollutionItemResponse(time: TimeInterval(1.0),
                                     main: AirPollutionItemResponse.AirQualityIndex.init(aqi: 1),
                                     components: builder.buildAirComponents_All())
        ]

        air = AirPollutionResponse(coord: coord, list: list)
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        data = try! encoder.encode(air)
    }
}



class BuilderMockAirPollutionResponse {
    
    func buildAirComponents_All() -> AirPollutionItemResponse.AirComponents {
        return AirPollutionItemResponse.AirComponents(co:    211.95,
                                                      no:    0.05,
                                                      no2:   11.31,
                                                      o3:    52.21,
                                                      so2:   5.48,
                                                      pm2_5: 0.5,
                                                      pm10:  1.09,
                                                      nh3:   0.35)
    }
    
    // Only: NO2, O3, PM2.5, PM10
    func buildAirComponents_CAQIEuropeScale() -> AirPollutionItemResponse.AirComponents {
        return AirPollutionItemResponse.AirComponents(co:    nil,
                                                      no:    nil,
                                                      no2:   11.31,
                                                      o3:    52.21,
                                                      so2:   nil,
                                                      pm2_5: 0.5,
                                                      pm10:  1.09,
                                                      nh3:   nil)
    }
    
    // Only: PM10, PM2.5, NO2, O3, CO, SO2, NH3, (Pb)
    func buildAirComponents_AQIIndiaScale() -> AirPollutionItemResponse.AirComponents {
        return AirPollutionItemResponse.AirComponents(co:    211.95,
                                                      no:    nil,
                                                      no2:   11.31,
                                                      o3:    52.21,
                                                      so2:   5.48,
                                                      pm2_5: 0.5,
                                                      pm10:  1.09,
                                                      nh3:   0.35)
    }
}
