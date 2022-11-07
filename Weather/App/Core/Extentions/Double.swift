//
//  Double+ToString.swift
//  Weather
//
//  Created by Владимир on 19.05.2022.
//

import Foundation

extension Double {
    
    public func toStringWithDegreeSymbol() -> String {
        let x = Int.init(self.rounded(.toNearestOrAwayFromZero))
        return x > 0 ? "+\(x)\u{00B0}" : "\(x)\u{00B0}"
    }
    
    public func toTemperature(in unit: TemperatureUnits) -> Double {
        var temperature: Double
        switch unit {
        case .celsius:    temperature = self
        case .fahrenheit: temperature = 9.0/5.0 * self + 32.0
        case .kelvin:     temperature = self + 273.15
        }
        return temperature
    }
    
    public func toWindSpeed(in unit: WindSpeedUnits) -> Double {
        switch unit {
        case .ms:  return self
        case .kmh: return self * 3.6
        case .mph: return self * 2.24
        }
    }
}
