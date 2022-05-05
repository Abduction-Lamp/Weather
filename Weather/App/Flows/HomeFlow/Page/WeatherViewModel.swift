//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Владимир on 04.05.2022.
//

import Foundation

protocol WeatherViewModelProtocol {
    var city: CityData { get }
    var weather: Bindable<OneCallResponse?> { get }
    
    func feach()
}

final class WeatherViewModel: WeatherViewModelProtocol {
    
    var city: CityData
    var weather = Bindable<OneCallResponse?>(nil)
    
    init(city: CityData) {
        self.city = city
    }
    
    deinit {
        print("😻\tDeinit WeatherViewModel")
    }
    
    
    func feach() {
        Network().getWeatherOneCall(lat: city.latitude, lon: city.longitude) { [weak self] response in
            switch response {
            case .success(let result):
                self?.weather.value = result
            case .failure(let error):
                print("\(error.description)")
            }
        }
    }
}
