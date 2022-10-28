//
//  WeatherAirPollutionModel.swift
//  Weather
//
//  Created by Владимир on 23.10.2022.
//

import UIKit

struct WeatherAirPollutionModel {
    
    let aqi: Int
    let airComponents: [ChemicalElements]
    
    init(aqi: Int, co: Double?, no: Double?, no2: Double?, o3: Double?, so2: Double?, pm2_5: Double?, pm10: Double?, nh3: Double?) {
        self.aqi = aqi
        var components: [ChemicalElements] = []
 
        if let co = co {
            components.append(.co(co))
        }
        if let no = no {
            components.append(.no(no))
        }
        if let no2 = no2 {
            components.append(.no2(no2))
        }
        if let o3 = o3 {
            components.append(.o3(o3))
        }
        if let so2 = so2 {
            components.append(.so2(so2))
        }
        if let pm2_5 = pm2_5 {
            components.append(.pm2_5(pm2_5))
        }
        if let pm10 = pm10 {
            components.append(.pm10(pm10))
        }
        if let nh3 = nh3 {
            components.append(.nh3(nh3))
        }
        airComponents = components
    }
    
    init(response: AirPollutionItemResponse) {
        self.init(aqi: response.main.aqi,
                  co: response.components.co,
                  no: response.components.no,
                  no2: response.components.no2,
                  o3: response.components.o3,
                  so2: response.components.so2,
                  pm2_5: response.components.pm2_5,
                  pm10: response.components.pm10,
                  nh3: response.components.nh3)
    }
}
