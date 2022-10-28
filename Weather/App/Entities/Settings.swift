//
//  Settings.swift
//  Weather
//
//  Created by Владимир on 13.04.2022.
//

import Foundation

final class Settings {
    
    var cities: Bindable<[CityData]>
    var units: Bindable<Unit>

    init() {
        cities = Bindable<[CityData]>([])
        units = Bindable<Unit>(Unit())
    }

    
    public func add(_ city: CityData) -> Bool {
        if cities.value.contains(city) { return false }
        cities.value.append(city)
        return true
    }
    
    public func remove(city: CityData) -> CityData? {
        if let index = cities.value.firstIndex(of: city) {
            return cities.value.remove(at: index)
        }
        return nil
    }
    
    public func remove(index: Int) -> CityData? {
        if (index >= 0) && (index < cities.value.count) {
            return cities.value.remove(at: index)
        }
        return nil
    }
    
    public func move(at sourceIndex: Int, to destinationIndex: Int) {
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
        let unitsDecode = Unit(temperature: try values.decode(TemperatureUnits.self, forKey: .temperature),
                               windSpeed: try values.decode(WindSpeedUnits.self, forKey: .windSpeed),
                               pressure: try values.decode(PressureUnits.self, forKey: .pressure))
        
        cities.value = try values.decode([CityData].self, forKey: .cities)
        units.value = unitsDecode
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(cities.value, forKey: .cities)
        try container.encode(units.value.temperature, forKey: .temperature)
        try container.encode(units.value.windSpeed, forKey: .windSpeed)
        try container.encode(units.value.pressure, forKey: .pressure)
    }
}


extension Settings: Equatable {
    
    static func == (lhs: Settings, rhs: Settings) -> Bool {
        lhs.cities.value == rhs.cities.value &&
        lhs.units.value.temperature == rhs.units.value.temperature &&
        lhs.units.value.windSpeed == rhs.units.value.windSpeed &&
        lhs.units.value.pressure == rhs.units.value.pressure
    }
}
