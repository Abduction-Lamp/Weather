//
//  WeatherAirPollutionModel.swift
//  Weather
//
//  Created by Владимир on 23.10.2022.
//

import UIKit

struct WeatherAirPollutionModel {
    typealias AirComponents = (name: String, designation: String, value: String, color: UIColor)
    
    let aqi: Int
    let airComponents: [AirComponents]
    
    init(aqi: Int, co: Double?, no: Double?, no2: Double?, o3: Double?, so2: Double?, pm2_5: Double?, pm10: Double?, nh3: Double?) {
        self.aqi = aqi
        var components: [AirComponents] = []
 
        if let co = co {
            components.append((name: NSLocalizedString("AirIndicatorView.co", comment: "CO"),
                               designation: "CO",
                               value: co.description,
                               color: CAQIEuropeScale.init(for: .co(co)).getColor()))
        }
        if let no = no {
            components.append((name: NSLocalizedString("AirIndicatorView.no", comment: "NO"),
                               designation: "NO",
                               value: no.description,
                               color: CAQIEuropeScale.init(for: .no(no)).getColor()))
        }
        if let no2 = no2 {
            components.append((name: NSLocalizedString("AirIndicatorView.no2", comment: "NO2"),
                               designation: "NO\u{2082}",
                               value: no2.description,
                               color: CAQIEuropeScale.init(for: .no2(no2)).getColor()))
        }
        if let o3 = o3 {
            components.append((name: NSLocalizedString("AirIndicatorView.o3", comment: "O3"),
                               designation: "O\u{2083}",
                               value: o3.description,
                               color: CAQIEuropeScale.init(for: .o3(o3)).getColor()))
        }
        if let so2 = so2 {
            components.append((name: NSLocalizedString("AirIndicatorView.so2", comment: "SO2"),
                               designation: "SO\u{2082}",
                               value: so2.description,
                               color: CAQIEuropeScale.init(for: .so2(so2)).getColor()))
        }
        if let pm2_5 = pm2_5 {
            components.append((name: NSLocalizedString("AirIndicatorView.pm2_5", comment: "PM2_5"),
                               designation: "PM\u{2082}\u{2085}",
                               value: pm2_5.description,
                               color: CAQIEuropeScale.init(for: .pm2_5(pm2_5)).getColor()))
        }
        if let pm10 = pm10 {
            components.append((name: NSLocalizedString("AirIndicatorView.pm10", comment: "PM10"),
                               designation: "PM\u{2081}\u{2080}",
                               value: pm10.description,
                               color: CAQIEuropeScale.init(for: .pm10(pm10)).getColor()))
        }
        if let nh3 = nh3 {
            components.append((name: NSLocalizedString("AirIndicatorView.nh3", comment: "NH3"),
                               designation: "NH\u{2083}",
                               value: nh3.description,
                               color: CAQIEuropeScale.init(for: .nh3(nh3)).getColor()))
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
