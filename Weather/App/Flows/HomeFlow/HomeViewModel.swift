//
//  HomeViewModel.swift
//  Weather
//
//  Created by Владимир on 04.05.2022.
//

import Foundation

final class HomeViewModel {
    
    private weak var storage: StorageServiceProtocol?
    private weak var network: NetworkServiceProtocol?
    
    private weak var settings: Settings?
    
    
//    private var WeatherViewModelList: [WeatherViewModel]  = []
    
    init(settings: Settings, storage: StorageServiceProtocol, network: NetworkServiceProtocol) {
        self.settings = settings
        self.storage = storage
        self.network = network
    }
    
    
    
}
