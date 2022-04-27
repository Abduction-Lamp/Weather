//
//  SettingsCellViewModel.swift
//  Weather
//
//  Created by Владимир on 16.04.2022.
//

import Foundation

protocol SettingsCellViewModelProtocol: AnyObject {
    var data: SettingsCellData { get }
    var selected: Int { get }
    
    init(_ type: MetaType.Type, from settings: Settings)
    
    func save(selected index: Int)
}


final class SettingsCellViewModel: SettingsCellViewModelProtocol {
    var data: SettingsCellData
    var selected: Int
    private weak var settings: Settings?
    
    private let metaType: MetaType.Type
    
    init(_ type: MetaType.Type, from settings: Settings) {
        self.metaType = type
        self.settings = settings

        switch metaType {
        case let meta where meta is Unit.Temperature.Type:
            data = SettingsCellData(label: "Температура", items: ["\u{00B0}C", "\u{00B0}F", "\u{00B0}K"])
            selected = settings.temperature.rawValue
        case let meta where meta is Unit.WindSpeed.Type:
            data = SettingsCellData(label: "Скорость ветра", items: ["м/с", "км/ч"])
            selected = settings.windSpeed.rawValue
        case let meta where meta is Unit.Pressure.Type:
            data = SettingsCellData(label: "Давление", items: ["мм рт. ст.", "гПа"])
            selected = settings.pressure.rawValue
        default:
            data = SettingsCellData(label: "", items: [])
            selected = 0
        }
    }
    
    deinit {
        print("♻️\tDeinit SettingsCellViewModel")
    }
    
    
    func save(selected index: Int) {
        selected = index
        switch metaType {
        case let meta where meta is Unit.Temperature.Type:
            settings?.temperature = Unit.Temperature.init(rawValue: selected) ?? Unit.defaultValue.temperature
        case let meta where meta is Unit.WindSpeed.Type:
            settings?.windSpeed = Unit.WindSpeed.init(rawValue: selected) ?? Unit.defaultValue.windSpeed
        case let meta where meta is Unit.Pressure.Type:
            settings?.pressure = Unit.Pressure.init(rawValue: selected) ?? Unit.defaultValue.pressure
        default:
            break
        }
    }
}
