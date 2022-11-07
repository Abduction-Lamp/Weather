//
//  Unit.swift
//  Weather
//
//  Created by Владимир on 13.04.2022.
//

import Foundation

protocol MetaType { }

struct Unit: Codable {
    typealias Triplet = (temperature: TemperatureUnits, windSpeed: WindSpeedUnits, pressure: PressureUnits)
    static let defaultValue: Triplet = (temperature: .celsius, windSpeed: .kmh, pressure: .hPa)
    
    let temperature: TemperatureUnits
    let windSpeed: WindSpeedUnits
    let pressure: PressureUnits
    
    init() {
        temperature = Unit.defaultValue.temperature
        windSpeed = Unit.defaultValue.windSpeed
        pressure = Unit.defaultValue.pressure
    }
    
    init(temperature: TemperatureUnits, windSpeed: WindSpeedUnits, pressure: PressureUnits) {
        self.temperature = temperature
        self.windSpeed = windSpeed
        self.pressure = pressure
    }
}

public enum TemperatureUnits: Int, Codable, CustomStringConvertible, MetaType {
    case celsius = 0, fahrenheit, kelvin
    
    public var description: String {
        switch self {
        case .celsius:
            return "\u{00B0}C"
        case .fahrenheit:
            return "\u{00B0}F"
        case .kelvin:
            return "K"
        }
    }
}

public enum WindSpeedUnits: Int, Codable, CustomStringConvertible, MetaType {
    case ms = 0, kmh, mph
    
    public var description: String {
        switch self {
        case .ms:
            return NSLocalizedString("Units.Speed.ms", comment: "ms")
        case .kmh:
            return NSLocalizedString("Units.Speed.kmh", comment: "km/h")
        case .mph:
            return NSLocalizedString("Units.Speed.mph", comment: "mph")
        }
    }
}

public enum PressureUnits: Int, Codable, CustomStringConvertible, MetaType {
    case mmHg = 0, hPa, bar
    
    public var description: String {
        switch self {
        case .mmHg:
            return NSLocalizedString("Units.Pressure.mmHg", comment: "mm Hg")
        case .hPa:
            return NSLocalizedString("Units.Pressure.hPa", comment: "hPa")
        case .bar:
            return NSLocalizedString("Units.Pressure.bar", comment: "bar")
        }
    }
}
