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
    func makeWeatherDailyModel() -> [WeatherDailyModel]
}


final class WeatherViewModel {
    
    var city: CityData
    var weather = Bindable<OneCallResponse?>(nil)
    
    private weak var network: NetworkServiceProtocol?
    private var iconManager = IconService()
    
    init(city: CityData, network: NetworkServiceProtocol) {
        self.city = city
        self.network = network
    }
    
    deinit {
        print("😻\tDeinit WeatherViewModel")
    }
}


// MARK: - WeatherViewModelProtocol
//
extension WeatherViewModel: WeatherViewModelProtocol {
    
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
    
    
    // MARK: Make models
    ///
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
        if let value = weather.value, let hourly = value.hourly {

            for (index, response) in hourly.enumerated() where index < 24 {
                let hour = response.time.toStringLocolTime(offset: value.timezoneOffset, format: "HH")
                let icon = iconManager.fetch(conditions: response.weather.first?.id,
                                             time: response.time,
                                             sunrise: value.current?.sunrise,
                                             sunset: value.current?.sunset)
                model.append(WeatherHourlyModel(time: index == 0 ? "Cейчас" : hour,
                                                icon: icon,
                                                temperature: response.temp.toStringWithDegreeSymbol()))
            }   
            ///
            /// Вставка информации о sunrise и sunset
            ///
            if let sunrise = weather.value?.current?.sunrise,
               let sunset = weather.value?.current?.sunset,
               let sunriseIndex = model.firstIndex(where: { $0.time == sunrise.toStringLocolTime(offset: value.timezoneOffset, format: "HH") }),
               let sunsetIndex = model.firstIndex(where: { $0.time == sunset.toStringLocolTime(offset: value.timezoneOffset, format: "HH") }) {
                model.insert(WeatherHourlyModel(time: sunrise.toStringLocolTime(offset: value.timezoneOffset, format: "HH:mm"),
                                                icon: iconManager.fetch(conditions: IconService.ExpandedIconSet.sunrise.rawValue),
                                                temperature: "Восход солнца"), at: sunriseIndex + 1)
                model.insert(WeatherHourlyModel(time: sunset.toStringLocolTime(offset: value.timezoneOffset, format: "HH:mm"),
                                                icon: iconManager.fetch(conditions: IconService.ExpandedIconSet.sunset.rawValue),
                                                temperature: "Заход солнца"), at: sunsetIndex + 1)
            }
        }
        return model
    }
    
    func makeWeatherDailyModel() -> [WeatherDailyModel] {
        var model: [WeatherDailyModel] = []
        if let value = weather.value, let daily = value.daily {
            for (index, response) in daily.enumerated() {
                let day = response.time.toStringLocolTime(offset: value.timezoneOffset, format: "E.,  d MMM")
                let temperature = response.temp.min.toStringWithDegreeSymbol() + " ... " + response.temp.max.toStringWithDegreeSymbol()
                model.append(WeatherDailyModel(day: index == 0 ? "Сегодня" : day,
                                               icon: iconManager.fetch(conditions: response.weather.first?.id),
                                               temperature: temperature))
            }
        }
        return model
    }
}
