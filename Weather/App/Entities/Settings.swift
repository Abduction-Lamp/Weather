//
//  Settings.swift
//  Weather
//
//  Created by Владимир on 13.04.2022.
//

import Foundation

final class Settings {
    
    var cities: Bindable<[CityData]>
    
    var temperature: Bindable<Unit.Temperature>
    var windSpeed: Bindable<Unit.WindSpeed>
    var pressure: Bindable<Unit.Pressure>
    
    
    init() {
        cities = Bindable<[CityData]>([])
        
        temperature = Bindable<Unit.Temperature>(Unit.defaultValue.temperature)
        windSpeed = Bindable<Unit.WindSpeed>(Unit.defaultValue.windSpeed)
        pressure = Bindable<Unit.Pressure>(Unit.defaultValue.pressure)
    }

    
    func add(_ city: CityData) -> Bool {
        if cities.value.contains(city) { return false }
        cities.value.append(city)
        return true
    }
    
    func remove(city: CityData) -> CityData? {
        if let index = cities.value.firstIndex(of: city) {
            return cities.value.remove(at: index)
        }
        return nil
    }
    
    func remove(index: Int) -> CityData? {
        if (index >= 0) && (index < cities.value.count) {
            return cities.value.remove(at: index)
        }
        return nil
    }
    
    func move(at sourceIndex: Int, to destinationIndex: Int) {
        guard
            sourceIndex != destinationIndex,
            sourceIndex >= 0, sourceIndex < cities.value.count,
            destinationIndex >= 0, destinationIndex < cities.value.count
        else { return }
        
        let city = cities.value[sourceIndex]
        cities.value.remove(at: sourceIndex)
        cities.value.insert(city, at: destinationIndex)
    }
}


extension Settings: Codable {
    
    enum CodingKeys: String, CodingKey {
        case cities, temperature, windSpeed, pressure
    }
    
    
    convenience init(from decoder: Decoder) throws {
        self.init()
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        cities.value = try values.decode([CityData].self, forKey: .cities)
        temperature.value = try values.decode(Unit.Temperature.self, forKey: .temperature)
        windSpeed.value = try values.decode(Unit.WindSpeed.self, forKey: .windSpeed)
        pressure.value = try values.decode(Unit.Pressure.self, forKey: .pressure)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(cities.value, forKey: .cities)
        try container.encode(temperature.value, forKey: .temperature)
        try container.encode(windSpeed.value, forKey: .windSpeed)
        try container.encode(pressure.value, forKey: .pressure)
    }
}


extension Settings: Equatable {
    
    static func == (lhs: Settings, rhs: Settings) -> Bool {
        lhs.cities.value == rhs.cities.value &&
        lhs.temperature.value == rhs.temperature.value &&
        lhs.windSpeed.value == rhs.windSpeed.value &&
        lhs.pressure.value == rhs.pressure.value
    }
}
