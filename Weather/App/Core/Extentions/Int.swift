//
//  Int.swift
//  Weather
//
//  Created by Владимир on 25.05.2022.
//

import UIKit

extension Int {
    
    func toRadians() -> CGFloat {
        return CGFloat(Double.init(self) * Double.pi / 180.0)
    }
    
    func toPressure(in unit: PressureUnits) -> Double {
        switch unit {
        case .mmHg:
            let torr = 0.750064
            return (torr * Double(self)).rounded(.toNearestOrAwayFromZero)
        case .hPa:
            return Double(self)
        case .bar:
            return (0.001 * Double(self))
        }
    }
    
    func toPressureToString(in unit: PressureUnits) -> String {
        let measurements = toPressure(in: unit)
        switch unit {
        case .mmHg:
            return String(Int(measurements.rounded(.toNearestOrAwayFromZero)))
        case .hPa:
            return String(self)
        case .bar:
            return String(format: "%.3f", measurements)
        }
    }
}
