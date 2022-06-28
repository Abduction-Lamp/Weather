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


final class HomeViewModel {
    private weak var storage: StorageServiceProtocol?
    private weak var network: NetworkServiceProtocol?
    private weak var location: LocationServiceProtoco?
    private weak var settings: Settings?
    
    var pages = Bindable<[WeatherViewController]>([])

    init(settings: Settings, storage: StorageServiceProtocol, network: NetworkServiceProtocol, location: LocationServiceProtoco?) {
        self.settings = settings
        self.storage = storage
        self.network = network
        self.location = location
        
        let locationWeatherViewModel = LocationWeatherViewModel(city: nil, network: network, settings: settings, location: location)
        pages.value.append(WeatherViewController.init(viewModel: locationWeatherViewModel))
        
        settings.cities.bind { [weak self] list in
            self?.pagemaker(cities: list)
        }
        
        settings.units.bind { [weak self] _ in
            self?.updateView()
        }
    }


    private func pagemaker(cities: [CityData]) {
        guard
            let settings = settings,
            let network = network,
            let locationPage = pages.value.first
        else { return }
        
        var list: [WeatherViewController] = [locationPage]
        
        for city in cities {
            let weatherViewModel = WeatherViewModel(city: city, network: network, settings: settings)
            list.append(WeatherViewController(viewModel: weatherViewModel))
        } 
        pages.value = list
    }
    
    private func updateView() {
        pages.value.forEach { weatherViewcontroller in
            weatherViewcontroller.weatherView.table.reloadData()
        }
    }
}


// MARK: - HomeViewModelProtocol
//
extension HomeViewModel: HomeViewModelProtocol {
    
    func makeSettingsViewModel() -> SettingsViewModelProtocol? {
        guard let settings = settings, let storage = storage, let network = network else { return nil }
        return SettingsViewModel(settings: settings, storage: storage, network: network)
    }
}
