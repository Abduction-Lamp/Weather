//
//  Unit.swift
//  Weather
//
//  Created by Владимир on 13.04.2022.
//

import Foundation

struct Unit: Codable {
    
    typealias Default = (temperature: Unit.Temperature, windSpeed: Unit.WindSpeed, pressure: Unit.Pressure)
    static let defaultValue: Default = (temperature: .celsius, windSpeed: .kmh, pressure: .hPa)
    
    enum Temperature: Int, Codable {
        case celsius = 0, fahrenheit, kelvin
    }
    enum WindSpeed: Int, Codable {
        case kmh = 0, mph, knot
    }
    enum Pressure: Int, Codable {
        case mmHg = 0, hPa, bar
    }
}
