//
//  SettingsViewModel.swift
//  Weather
//
//  Created by Владимир on 14.04.2022.
//

import Foundation

enum SettingsDisplayType: Int {
    case cities, settings, search
}

protocol SettingsViewModelProtocol: AnyObject {
    
    var display: Bindable<SettingsDisplayType> { get set }
    
    func numberOfRows() -> Int
    func changeDisplayType(_ type: SettingsDisplayType)
    func save()
    func moveItem(at sourceIndex: Int, to destinationIndex: Int)
    func cityCellViewModel(for indexPath: IndexPath) -> SettingsCityCellViewModelProtocol?
}



final class SettingsViewModel: SettingsViewModelProtocol {

    var display = Bindable<SettingsDisplayType>(.cities)

    
    private weak var settings: Settings?
    

    init(settings: Settings) {
        self.settings = settings
    }
    
    deinit {
        print("♻️\tDeinit SettingsViewModel")
    }
}


extension SettingsViewModel {
    
    func numberOfRows() -> Int {
        switch display.value {
        case .cities:
            return settings?.cities.count ?? 0
        case .search:
            return 0
        case .settings:
            return 3
        }
    }
    
    func changeDisplayType(_ type: SettingsDisplayType) {
        display.value = type
    }
    
    func save() {
        print("save")
    }
    
    func moveItem(at sourceIndex: Int, to destinationIndex: Int) {
        print(sourceIndex)
        print(destinationIndex)
    }
    
    func cityCellViewModel(for indexPath: IndexPath) -> SettingsCityCellViewModelProtocol? {
        guard
            let count = settings?.cities.count,
            indexPath.row < count,
            let city = settings?.cities[indexPath.row]
        else { return nil }
        
        let cityData = SettingsCityCellData(city: city.city, icon: "", temperature: "17")
        return SettingsCityCellViewModel(city: cityData)
    }
}
