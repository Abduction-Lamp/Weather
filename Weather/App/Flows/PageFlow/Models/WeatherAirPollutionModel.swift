//
//  WeatherAirPollutionModel.swift
//  Weather
//
//  Created by Владимир on 23.10.2022.
//

import Foundation

struct WeatherAirPollutionModel {
    let aqi: Int
    let airComponents: [ChemicalElements]
    
    init(aqi: Int, co: Double?, no: Double?, no2: Double?, o3: Double?, so2: Double?, pm2_5: Double?, pm10: Double?, nh3: Double?) {
        self.aqi = aqi
        var components: [ChemicalElements] = []
        
        if let co = co {
            let element = ChemicalElements.co(co)
            components.append(element)
        }
        if let no = no {
            let element = ChemicalElements.no(no)
            components.append(element)
        }
        if let no2 = no2 {
            let element = ChemicalElements.no2(no2)
            components.append(element)
        }
        if let o3 = o3 {
            let element = ChemicalElements.o3(o3)
            components.append(element)
        }
        if let so2 = so2 {
            let element = ChemicalElements.so2(so2)
            components.append(element)
        }
        if let pm2_5 = pm2_5 {
            let element = ChemicalElements.pm2_5(pm2_5)
            components.append(element)
        }
        if let pm10 = pm10 {
            let element = ChemicalElements.pm10(pm10)
            components.append(element)
        }
        if let nh3 = nh3 {
            let element = ChemicalElements.nh3(nh3)
            components.append(element)
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
