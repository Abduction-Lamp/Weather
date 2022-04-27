//
//  Unit.swift
//  Weather
//
//  Created by Владимир on 13.04.2022.
//

import Foundation

protocol MetaType { }

struct Unit: Codable {
    
    typealias Default = (temperature: Unit.Temperature, windSpeed: Unit.WindSpeed, pressure: Unit.Pressure)
    static let defaultValue: Default = (temperature: .celsius, windSpeed: .kmh, pressure: .hPa)
    
    enum Temperature: Int, Codable, MetaType {
        case celsius = 0, fahrenheit, kelvin
    }
    enum WindSpeed: Int, Codable, MetaType {
        case kmh = 0, mph, knot
    }
    enum Pressure: Int, Codable, MetaType {
        case mmHg = 0, hPa, bar
    }
}
