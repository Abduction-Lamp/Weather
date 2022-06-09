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
    var statusDay: Bindable<TimeOfDay?> { get }
    
    func feach()
    
    func makeWeatherCityHeaderModel() -> WeatherCityHeaderModel
    func makeWeatherHourlyModel() -> [WeatherHourlyModel]
    func makeWeatherDailyModel() -> [WeatherDailyModel]
    func makeWeatherWindModel() -> WeatherWindModel
    func makeWeatherPressureAndHumidityModel() -> WeatherPressureAndHumidityModel
}


final class WeatherViewModel {
    
    var city: CityData
    var weather = Bindable<OneCallResponse?>(nil)
    var statusDay = Bindable<TimeOfDay?>(nil)
    
    private weak var settings: Settings?
    private weak var network: NetworkServiceProtocol?
    
    private var iconManager = IconService()
    
    init(city: CityData, network: NetworkServiceProtocol, settings: Settings?) {
        self.city = city
        self.network = network
        self.settings = settings
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
                if let time = result.current?.time, let sunrise = result.current?.sunrise,  let sunset = result.current?.sunset {
                    self?.statusDay.value = .init(time: time, sunrise: sunrise, sunset: sunset)
                }
            case .failure(let error):
                print("\(error.description)")
            }
        }
    }
    
    
    // MARK: Make models
    //
    func makeWeatherCityHeaderModel() -> WeatherCityHeaderModel {
        var temperature: String = ""
        if let temp = weather.value?.current?.temp, let settings = settings {
            temperature = temp.temperature(in: settings.units.value.temperature).toStringWithDegreeSymbol()
        }
        return WeatherCityHeaderModel(city: city.rus,
                                      temperature: temperature,
                                      description: weather.value?.current?.weather.first?.description ?? "")
    }
    
    func makeWeatherHourlyModel() -> [WeatherHourlyModel] {
        var model: [WeatherHourlyModel] = []
        if let value = weather.value, let hourly = value.hourly, let settings = settings {
            for (index, response) in hourly.enumerated() where index < 24 {
                let hour = response.time.toStringLocolTime(offset: value.timezoneOffset, format: "HH")
                let icon = iconManager.fetch(conditions: response.weather.first?.id,
                                             time: response.time,
                                             sunrise: value.current?.sunrise,
                                             sunset: value.current?.sunset)
                let temperature = response.temp.temperature(in: settings.units.value.temperature).toStringWithDegreeSymbol()
                model.append(WeatherHourlyModel(time: index == 0 ? "Cейчас" : hour, icon: icon, temperature: temperature))
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
        if let value = weather.value, let daily = value.daily, let settings = settings {
            for (index, response) in daily.enumerated() {
                let day = response.time.toStringLocolTime(offset: value.timezoneOffset, format: "E.,  d MMM")
                let temperature = response.temp.min.temperature(in: settings.units.value.temperature).toStringWithDegreeSymbol()
                                  + " ... "
                                  + response.temp.max.temperature(in: settings.units.value.temperature).toStringWithDegreeSymbol()
                model.append(WeatherDailyModel(day: index == 0 ? "Сегодня" : day,
                                               icon: iconManager.fetch(conditions: response.weather.first?.id),
                                               temperature: temperature))
            }
        }
        return model
    }
    
    func makeWeatherWindModel() -> WeatherWindModel {
        var measurement: String = ""
        var degrees: Int = 0
        let units: String = settings?.units.value.windSpeed.description ?? ""
        var text = ""
        var gust = ""
        var direction = ""
        
        if let value = weather.value?.current, let settings = settings {
            let speed = value.windSpeed.windSpeed(in: settings.units.value.windSpeed)
            
            measurement = String(Int(speed.rounded(.toNearestOrAwayFromZero)))
            degrees = value.windDeg
            
            if let windGust = value.windGust, value.windSpeed < windGust {
                let gustSpeed = windGust.windSpeed(in: settings.units.value.windSpeed)
                gust = ", с порывами до " + String(Int(gustSpeed.rounded(.toNearestOrAwayFromZero))) + " " + units
            }
            
            let stringDirection = WindDirection.init(degrees).rawValue
            if !stringDirection.isEmpty {
                direction = ", " + stringDirection
            }
            
            let measurementDescription = BeaufortScale.init(speed: value.windSpeed)
            switch measurementDescription {
            case .calm:
                text = measurementDescription.rawValue
            case .air, .light, .gentle, .moderate, .fresh, .strong, .high, .gale, .severe:
                text = "Ветер \(measurementDescription.rawValue)\(direction)\nСкорасть ветра \(measurement) \(units)\(gust)"
            case .storm, .violent, .hurricane:
                text = "\(measurementDescription.rawValue)\(direction)\nСкорасть ветра \(measurement) \(units)\(gust)"
            case .indefinite:
                text = ""
            }
        }
        return WeatherWindModel(measurement: measurement, degrees: degrees, units: units, text: text)
    }

    func makeWeatherPressureAndHumidityModel() -> WeatherPressureAndHumidityModel {
        var measurement: String = ""
        var pressure: Int = 0
        let units: String = settings?.units.value.pressure.description ?? ""
        var humidity: String = ""
        var dewPoint: String = ""

        if let value = weather.value?.current, let settings = settings {            
            measurement = value.pressure.pressureToString(in: settings.units.value.pressure)
            pressure = value.pressure
            
            humidity = "\(value.humidity) %"
            dewPoint = "Точка росы\nСейча: \(value.dewPoint.temperature(in: settings.units.value.temperature).toStringWithDegreeSymbol())."
        }
        
        return WeatherPressureAndHumidityModel(measurement: measurement,
                                               pressure: pressure,
                                               units: units,
                                               humidity: humidity,
                                               dewPoint: dewPoint)
    }
}
