//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Владимир on 04.05.2022.
//

import Foundation

protocol WeatherViewModelProtocol: AnyObject {
    var city: CityData { get }
    var weather: Bindable<OneCallResponse?> { get }
    
    func feach()
}

final class WeatherViewModel: WeatherViewModelProtocol {
    
    var city: CityData
    var weather = Bindable<OneCallResponse?>(nil)
    
    private weak var network: NetworkServiceProtocol?
    
    init(city: CityData, network: NetworkServiceProtocol) {
        self.city = city
        self.network = network
    }
    
    deinit {
        print("😻\tDeinit WeatherViewModel")
    }
    
    
    func feach() {
        network?.getWeatherOneCall(lat: city.latitude, lon: city.longitude, units: "metric", lang: "ru") { [weak self] response in
            switch response {
            case .success(let result):
                self?.weather.value = result
            case .failure(let error):
                print("\(error.description)")
            }
        }
    }
}
