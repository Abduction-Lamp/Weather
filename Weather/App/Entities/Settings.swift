//
//  Settings.swift
//  Weather
//
//  Created by Владимир on 13.04.2022.
//

import Foundation


final class Settings: Codable {
    
    var cities: [CityData]
    
    var temperature: Unit.Temperature
    var windSpeed: Unit.WindSpeed
    var pressure: Unit.Pressure
    
    
    init() {
        cities = []
        temperature = Unit.defaultValue.temperature
        windSpeed = Unit.defaultValue.windSpeed
        pressure = Unit.defaultValue.pressure
    }
    
    
    public func move(at sourceIndex: Int, to destinationIndex: Int) {
        guard
            sourceIndex != destinationIndex,
            sourceIndex >= 0, sourceIndex < cities.count,
            destinationIndex >= 0, destinationIndex < cities.count
        else { return }

        let city = cities[sourceIndex]
        cities.remove(at: sourceIndex)
        cities.insert(city, at: destinationIndex)
    }
}
