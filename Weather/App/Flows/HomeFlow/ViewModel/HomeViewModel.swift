//
//  HomeViewModel.swift
//  Weather
//
//  Created by Владимир on 05.05.2022.
//

import Foundation

protocol HomeViewModelProtocol: AnyObject {
    var pages: Bindable<[WeatherViewController]> { get }
    
    func makeSettingsViewModel() -> SettingsViewModelProtocol?
}


final class HomeViewModel: HomeViewModelProtocol {

    private weak var storage: StorageServiceProtocol?
    private weak var network: NetworkServiceProtocol?
    
    private weak var settings: Settings?
    
    var pages = Bindable<[WeatherViewController]>([])
    

    init(settings: Settings, storage: StorageServiceProtocol, network: NetworkServiceProtocol) {
        self.settings = settings
        self.storage = storage
        self.network = network
        
        settings.cities.bind { list in
            self.pagemaker(cities: list)
        }
    }

    private func pagemaker(cities: [CityData]) {
        guard
            let settings = settings,
            let network = network
        else { return }
        
        var list: [WeatherViewController] = []
        for city in settings.cities.value {
            let weatherViewModel = WeatherViewModel(city: city, network: network)
            list.append(WeatherViewController(viewModel: weatherViewModel))
        } 
        pages.value = list
    }
    
    
    func makeSettingsViewModel() -> SettingsViewModelProtocol? {
        guard let settings = settings, let storage = storage, let network = network else { return nil }
        return SettingsViewModel(settings: settings, storage: storage, network: network)
    }
}
