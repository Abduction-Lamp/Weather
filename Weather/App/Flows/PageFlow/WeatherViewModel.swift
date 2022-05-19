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
    
    func makeWeatherCityHeaderModel() -> WeatherCityHeaderModel
    func makeWeatherHourlyModel() -> [WeatherHourlyModel]
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
    
    
    func makeWeatherCityHeaderModel() -> WeatherCityHeaderModel {
        var temperature: String = ""
        if let temp = weather.value?.current?.temp {
            temperature = temp.toStringWithDegreeSymbol()
        }
        return WeatherCityHeaderModel(city: city.rus,
                                      temperature: temperature,
                                      description: weather.value?.current?.weather.first?.description ?? "")
    }
    
    func makeWeatherHourlyModel() -> [WeatherHourlyModel] {
        var model: [WeatherHourlyModel] = []
        if let hourly = weather.value?.hourly {
            hourly.forEach { response in
                model.append(WeatherHourlyModel(time: "response",
                                                icon: "response",
                                                temperature: response.temp.toStringWithDegreeSymbol()))
            }
        }
        return model
    }
}
