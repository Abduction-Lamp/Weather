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
    
    public func temperature(in unit: TemperatureUnits) -> Double {
        switch unit {
        case .celsius:    return self
        case .fahrenheit: return (9.0/5.0 * self + 32.0)
        case .kelvin:     return (self + 273.15)
        }
    }
    
    public func windSpeed(in unit: WindSpeedUnits) -> Double {
        switch unit {
        case .ms:  return self
        case .kmh: return 3.6 * self
        case .mph: return 2.24 * self
        }
    }
}
