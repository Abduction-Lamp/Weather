//
//  Settings.swift
//  Weather
//
//  Created by Владимир on 13.04.2022.
//

import Foundation

protocol SettingsProtocol {
    func move(at sourceIndex: Int, to destinationIndex: Int)
    func add(_ city: CityData) -> Bool
    func remove(city: CityData) -> CityData?
    func remove(index: Int) -> CityData?
}


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
}


extension Settings: SettingsProtocol {
    
    func add(_ city: CityData) -> Bool {
        if cities.contains(city) { return false }
        cities.append(city)
        return true
    }
    
    func remove(city: CityData) -> CityData? {
        if let index = cities.firstIndex(of: city) {
            return cities.remove(at: index)
        }
        return nil
    }
    
    func remove(index: Int) -> CityData? {
        return cities.remove(at: index)
    }
    
    func move(at sourceIndex: Int, to destinationIndex: Int) {
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
