//
//  SettingsViewModel.swift
//  Weather
//
//  Created by Владимир on 14.04.2022.
//

import Foundation

protocol SettingsViewModelProtocol: AnyObject {

    var searchResult: Bindable<[GeocodingResponse]> { get }
    
    func numberOfRows() -> Int
    func numberOfRowsSearchResult() -> Int
        
    func makeCityCellViewModel(for indexPath: IndexPath) -> SettingsCityCellViewModelProtocol?
    func makeSearchCityCellViewModel(for indexPath: IndexPath) -> SearchCityCellViewModelProtocol?
    func makeSettingsCellViewModel(_ type: MetaType.Type) -> SettingsCellViewModelProtocol?
    
    func searchCity(city: String)
    
    func save()
    func moveItem(at sourceIndex: Int, to destinationIndex: Int)
}



final class SettingsViewModel {
    private weak var settings: Settings?
    private weak var network: NetworkServiceProtocol?
    
    init(settings: Settings, network: NetworkServiceProtocol) {
        self.settings = settings
        self.network = network
    }
    
    deinit {
        print("♻️\tDeinit SettingsViewModel")
    }
    
    var searchResult = Bindable<[GeocodingResponse]>([])
}


extension SettingsViewModel: SettingsViewModelProtocol {
    
    func numberOfRows() -> Int {
        return settings?.cities.count ?? 0
    }

    func numberOfRowsSearchResult() -> Int {
        return searchResult.value.count
    }
    
    func save() {
        print("save")
    }
    
    func moveItem(at sourceIndex: Int, to destinationIndex: Int) {
        print(sourceIndex)
        print(destinationIndex)
    }
    
    func makeCityCellViewModel(for indexPath: IndexPath) -> SettingsCityCellViewModelProtocol? {
        guard
            let count = settings?.cities.count,
            indexPath.row < count,
            let city = settings?.cities[indexPath.row]
        else { return nil }
        
        let cityData = SettingsCityCellData(city: city.city, icon: "", temperature: "17")
        return SettingsCityCellViewModel(city: cityData)
    }
    
    func makeSearchCityCellViewModel(for indexPath: IndexPath) -> SearchCityCellViewModelProtocol? {
        if indexPath.row < searchResult.value.count {
            let city = searchResult.value[indexPath.row]
            let cityData = SearchCityCellData(city: city.name + ", " + city.country)
            return SearchCityCellViewModel(city: cityData)
        }
        return nil
    }
    
    func makeSettingsCellViewModel(_ type: MetaType.Type) -> SettingsCellViewModelProtocol? {
        guard let settings = settings else { return nil }
        return SettingsCellViewModel(type, from: settings)
    }
    
    func searchCity(city: String) {
        if city.isEmpty {
            searchResult.value = []
        } else {
            network?.getCoordinatesByLocationName(city: city) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let cities):
                    self.searchResult.value = cities
                case .failure(let error):
                    print(error.description)
                }
            }
        }
    }
}
