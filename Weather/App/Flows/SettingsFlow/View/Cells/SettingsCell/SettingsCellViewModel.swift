//
//  SettingsCellViewModel.swift
//  Weather
//
//  Created by Владимир on 16.04.2022.
//

import Foundation

protocol SettingsCellViewModelProtocol: AnyObject {
    var data: SettingsCellModel { get }
    var selected: Int { get }
    
    init(_ type: MetaType.Type, from settings: Settings)
    
    func save(selected index: Int)
}


final class SettingsCellViewModel: SettingsCellViewModelProtocol {
    var data: SettingsCellModel
    var selected: Int
    private weak var settings: Settings?
    
    private let metaType: MetaType.Type
    
    init(_ type: MetaType.Type, from settings: Settings) {
        self.metaType = type
        self.settings = settings

        switch metaType {
        case let meta where meta is TemperatureUnits.Type:
            let items = [TemperatureUnits.celsius.description, TemperatureUnits.fahrenheit.description, TemperatureUnits.kelvin.description]
            data = SettingsCellModel(label: "Температура", items: items)
            selected = settings.units.value.temperature.rawValue
        case let meta where meta is WindSpeedUnits.Type:
            let items = [WindSpeedUnits.ms.description, WindSpeedUnits.kmh.description, WindSpeedUnits.mph.description]
            data = SettingsCellModel(label: "Скорость ветра", items: items)
            selected = settings.units.value.windSpeed.rawValue
        case let meta where meta is PressureUnits.Type:
            let items = [PressureUnits.mmHg.description, PressureUnits.hPa.description]
            data = SettingsCellModel(label: "Давление", items: items)
            selected = settings.units.value.pressure.rawValue
        default:
            data = SettingsCellModel(label: "", items: [])
            selected = 0
        }
    }
    
    
    func save(selected index: Int) {
        guard let settings = settings else {
            return
        }
        let units: Unit
        selected = index

        switch metaType {
        case let meta where meta is TemperatureUnits.Type:
            units = Unit(temperature: TemperatureUnits.init(rawValue: selected) ?? Unit.defaultValue.temperature,
                         windSpeed: settings.units.value.windSpeed,
                         pressure: settings.units.value.pressure)
        case let meta where meta is WindSpeedUnits.Type:
            units = Unit(temperature: settings.units.value.temperature,
                         windSpeed: WindSpeedUnits.init(rawValue: selected) ?? Unit.defaultValue.windSpeed,
                         pressure: settings.units.value.pressure)
        case let meta where meta is PressureUnits.Type:
            units = Unit(temperature: settings.units.value.temperature,
                         windSpeed: settings.units.value.windSpeed,
                         pressure: PressureUnits.init(rawValue: selected) ?? Unit.defaultValue.pressure)
        default:
            units = Unit(temperature: Unit.defaultValue.temperature,
                         windSpeed: Unit.defaultValue.windSpeed,
                         pressure: Unit.defaultValue.pressure)
        }
        settings.units.value = units
    }
}
