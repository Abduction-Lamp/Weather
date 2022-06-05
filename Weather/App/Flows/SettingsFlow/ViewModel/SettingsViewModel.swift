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
        
    func makeCityCellViewModel(for indexPath: IndexPath) -> CityCellViewModelProtocol?
    func makeSearchCityCellViewModel(for indexPath: IndexPath) -> SearchCityCellViewModelProtocol?
    func makeSettingsCellViewModel(_ type: MetaType.Type) -> SettingsCellViewModelProtocol?
    
    func save()
    
    func moveItem(at sourceIndex: Int, to destinationIndex: Int)
    func addCity(for indexPath: IndexPath) -> Bool
    func removeCity(for indexPath: IndexPath) -> Bool
    
    func cancelSelection(for indexPath: IndexPath) -> Bool 

    func searchCity(city: String)
}


final class SettingsViewModel {
    
    private weak var settings: Settings?
    
    private weak var storage: StorageServiceProtocol?
    private weak var network: NetworkServiceProtocol?

    init(settings: Settings, storage: StorageServiceProtocol, network: NetworkServiceProtocol) {
        self.settings = settings
        self.storage = storage
        self.network = network
    }
    
    var searchResult = Bindable<[GeocodingResponse]>([])
}


// MARK: - SettingsViewModelProtocol
//
extension SettingsViewModel: SettingsViewModelProtocol {
    
    func numberOfRows() -> Int {
        return settings?.cities.value.count ?? 0
    }

    func numberOfRowsSearchResult() -> Int {
        return searchResult.value.count
    }
    
    // MARK: Make models
    ///
    func makeCityCellViewModel(for indexPath: IndexPath) -> CityCellViewModelProtocol? {
        guard
            let count = settings?.cities.value.count,
            indexPath.row < count,
            let city = settings?.cities.value[indexPath.row]
        else { return nil }
        
        let cityData = CityCellModel(city: city.rus, icon: "", temperature: "17")
        return CityCellViewModel(city: cityData)
    }
    
    func makeSearchCityCellViewModel(for indexPath: IndexPath) -> SearchCityCellViewModelProtocol? {
        if indexPath.row < searchResult.value.count {
            let city = searchResult.value[indexPath.row]
            let str: String = city.localNames?.ru ?? city.name
            let cityData = SearchCityCellModel(city: str + ", " + city.country)
            let model = SearchCityCellViewModel(city: cityData)
            if let settings = self.settings {
                model.isSaved = settings.cities.value.contains(CityData(geocoding: city))
            }
            return model
        }
        return nil
    }
    
    func makeSettingsCellViewModel(_ type: MetaType.Type) -> SettingsCellViewModelProtocol? {
        guard let settings = settings else { return nil }
        return SettingsCellViewModel(type, from: settings)
    }
    
    // MARK: Actions
    ///
    func save() {
        guard let storage = self.storage, let settings = self.settings else { return }
        storage.save(settings, completion: nil)
    }
    
    func moveItem(at sourceIndex: Int, to destinationIndex: Int) {
        settings?.move(at: sourceIndex, to: destinationIndex)
    }
        
    func addCity(for indexPath: IndexPath) -> Bool {
        guard
            let settings = self.settings,
            let storage = self.storage,
            indexPath.row < searchResult.value.count
        else { return false }
        
        let city = CityData(geocoding: searchResult.value[indexPath.row])
        if settings.add(city) {
            storage.save(settings, completion: nil)
            return true
        }
        return false
    }
    
    func removeCity(for indexPath: IndexPath) -> Bool {
        guard
            let settings = self.settings,
            let storage = self.storage,
            indexPath.row < settings.cities.value.count
        else { return false }
        
        if let _ = settings.remove(index: indexPath.row) {
            storage.save(settings, completion: nil)
            return true
        }
        return false
    }
    
    func cancelSelection(for indexPath: IndexPath) -> Bool {
        guard
            let settings = self.settings,
            let storage = self.storage,
            indexPath.row < searchResult.value.count
        else { return false }
        
        let city = CityData(geocoding: searchResult.value[indexPath.row])
        if let _ = settings.remove(city: city) {
            storage.save(settings, completion: nil)
            return true
        }
        return false
    }
    
    // MARK: Network
    ///
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
