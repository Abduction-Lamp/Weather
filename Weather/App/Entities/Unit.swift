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
            return "\u{00B0}K"
        }
    }
}

public enum WindSpeedUnits: Int, Codable, CustomStringConvertible, MetaType {
    case ms = 0, kmh, mph
    
    public var description: String {
        switch self {
        case .ms:
            return "м/c"
        case .kmh:
            return "км/ч"
        case .mph:
            return "миля/ч"
        }
    }
}

public enum PressureUnits: Int, Codable, CustomStringConvertible, MetaType {
    case mmHg = 0, hPa, bar
    
    public var description: String {
        switch self {
        case .mmHg:
            return "мм рт. ст."
        case .hPa:
            return "гПа"
        case .bar:
            return "бар"
        }
    }
}
