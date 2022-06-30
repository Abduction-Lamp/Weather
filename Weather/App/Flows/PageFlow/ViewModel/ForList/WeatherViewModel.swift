//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Владимир on 04.05.2022.
//

import UIKit

protocol WeatherViewModelProtocol: AnyObject {
    var city: CityData? { get set }
    var statusDay: Bindable<TimeOfDay?> { get }
    var state: Bindable<UIViewController.Mode> { get }
    
    func feach()
    
    func makeWeatherCityHeaderModel() -> WeatherCityHeaderModel
    func makeWeatherHourlyModel() -> [WeatherHourlyModel]
    func makeWeatherDailyModel() -> [WeatherDailyModel]
    func makeWeatherWindModel() -> WeatherWindModel
    func makeWeatherPressureAndHumidityModel() -> WeatherPressureAndHumidityModel
}


class WeatherViewModel {
    var city: CityData?
    var statusDay = Bindable<TimeOfDay?>(nil)
    var state = Bindable<UIViewController.Mode>(.none)
    
    private var weather: OneCallResponse?
    
    private weak var settings: Settings?
    private weak var network: NetworkServiceProtocol?
    private var iconManager = IconService()
    
    init(city: CityData?, network: NetworkServiceProtocol, settings: Settings?) {
        self.city = city
        self.network = network
        self.settings = settings
    }
}


// MARK: - WeatherViewModelProtocol
//
extension WeatherViewModel: WeatherViewModelProtocol {

    @objc
    public func feach() {
        guard let city = city else { return }
        
        state.value = .loading
        
        network?.getWeatherOneCall(lat: city.latitude,
                                   lon: city.longitude,
                                   units: "metric",
                                   lang: NSLocalizedString("General.Lang", comment: "Lang")) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let result):
                self.weather = result
                if let time = result.current?.time, let sunrise = result.current?.sunrise, let sunset = result.current?.sunset {
                    self.statusDay.value = .init(time: time, sunrise: sunrise, sunset: sunset)
                }
                self.state.value = .success(nil)
            case .failure(let error):
                self.state.value = .failure(error.description)
                print("\(error.description)")
            }
        }
    }
    
    
    // MARK: Make models
    //
    func makeWeatherCityHeaderModel() -> WeatherCityHeaderModel {
        guard let city = city else { return WeatherCityHeaderModel(city: "", temperature: "", description: "") }
        
        var temperature: String = ""
        if let temp = weather?.current?.temp, let settings = settings {
            temperature = temp.temperature(in: settings.units.value.temperature).toStringWithDegreeSymbol()
        }
        return WeatherCityHeaderModel(city: city.getName(lang: NSLocalizedString("General.Lang", comment: "Lang")),
                                      temperature: temperature,
                                      description: weather?.current?.weather.first?.description ?? "")
    }
    
    func makeWeatherHourlyModel() -> [WeatherHourlyModel] {
        var model: [WeatherHourlyModel] = []
        if let value = weather, let hourly = value.hourly, let settings = settings {
            let wordNow = NSLocalizedString("WeatherView.CommonWords.Now", comment: "Now")
            for (index, response) in hourly.enumerated() where index < 24 {
                let hour = response.time.toStringLocolTime(offset: value.timezoneOffset, format: "HH")
                let icon = iconManager.fetch(conditions: response.weather.first?.id,
                                             time: response.time,
                                             sunrise: value.current?.sunrise,
                                             sunset: value.current?.sunset)
                let temperature = response.temp.temperature(in: settings.units.value.temperature).toStringWithDegreeSymbol()
                model.append(WeatherHourlyModel(time: index == 0 ? wordNow : hour, icon: icon, temperature: temperature))
            }
            
            ///
            /// Вставка информации о sunrise и sunset
            ///
            if let sunrise = weather?.current?.sunrise,
               let sunset = weather?.current?.sunset,
               let sunriseIndex = model.firstIndex(where: { $0.time == sunrise.toStringLocolTime(offset: value.timezoneOffset, format: "HH") }),
               let sunsetIndex = model.firstIndex(where: { $0.time == sunset.toStringLocolTime(offset: value.timezoneOffset, format: "HH") }) {
                let wordSunrise = NSLocalizedString("WeatherView.CommonWords.Sunrise", comment: "Sunrise")
                let wordSunset = NSLocalizedString("WeatherView.CommonWords.Sunset", comment: "Sunset")
                model.insert(WeatherHourlyModel(time: sunrise.toStringLocolTime(offset: value.timezoneOffset, format: "HH:mm"),
                                                icon: iconManager.fetch(conditions: IconService.ExpandedIconSet.sunrise.rawValue),
                                                temperature: wordSunrise), at: sunriseIndex + 1)
                model.insert(WeatherHourlyModel(time: sunset.toStringLocolTime(offset: value.timezoneOffset, format: "HH:mm"),
                                                icon: iconManager.fetch(conditions: IconService.ExpandedIconSet.sunset.rawValue),
                                                temperature: wordSunset), at: sunsetIndex + 1)
            }
        }
        return model
    }
    
    func makeWeatherDailyModel() -> [WeatherDailyModel] {
        var model: [WeatherDailyModel] = []
        if let value = weather, let daily = value.daily, let settings = settings {
            for (index, response) in daily.enumerated() {
                let day = response.time.toStringLocolTime(offset: value.timezoneOffset, format: "E.,  d MMM")
                let temperature = response.temp.min.temperature(in: settings.units.value.temperature).toStringWithDegreeSymbol()
                                  + " ... "
                                  + response.temp.max.temperature(in: settings.units.value.temperature).toStringWithDegreeSymbol()
                let wordToday = NSLocalizedString("WeatherView.CommonWords.Today", comment: "Today")
                model.append(WeatherDailyModel(day: index == 0 ? wordToday : day,
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
        
        let gustLocalWord = NSLocalizedString("WeatherView.CommonWords.GustWind", comment: "gust wind")
        let windLocalWord = NSLocalizedString("WeatherView.CommonWords.WindTitle", comment: "Wind")
        let windSpeedLocalWord = NSLocalizedString("WeatherView.CommonWords.WindSpeed", comment: "Wind speed")
        
        if let value = weather?.current, let settings = settings {
            let speed = value.windSpeed.windSpeed(in: settings.units.value.windSpeed)
            
            measurement = String(Int(speed.rounded(.toNearestOrAwayFromZero)))
            degrees = value.windDeg
            
            if let windGust = value.windGust, value.windSpeed < windGust {
                let gustSpeed = windGust.windSpeed(in: settings.units.value.windSpeed)
                gust = gustLocalWord + String(Int(gustSpeed.rounded(.toNearestOrAwayFromZero))) + " " + units
            }
            
            let stringDirection = WindDirection.init(degrees).description
            if !stringDirection.isEmpty {
                direction = ", " + stringDirection
            }
            
            let measurementDescription = BeaufortScale.init(speed: value.windSpeed)
            switch measurementDescription {
            case .calm:
                text = measurementDescription.description
            case .air, .light, .gentle, .moderate, .fresh, .strong, .high, .gale, .severe:
                text = "\(windLocalWord) \(measurementDescription.description)\(direction)\n\(windSpeedLocalWord) \(measurement) \(units)\(gust)"
            case .storm, .violent, .hurricane:
                text = "\(measurementDescription.description)\(direction)\n\(windSpeedLocalWord) \(measurement) \(units)\(gust)"
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

        if let value = weather?.current, let settings = settings {
            measurement = value.pressure.pressureToString(in: settings.units.value.pressure)
            pressure = value.pressure
            
            let wordNow = NSLocalizedString("WeatherView.CommonWords.Now", comment: "Now")
            let wordDewPoint = NSLocalizedString("WeatherView.CommonWords.DewPoint", comment: "Dew point")
            humidity = "\(value.humidity) %"
            dewPoint = "\(wordDewPoint)\n\(wordNow): \(value.dewPoint.temperature(in: settings.units.value.temperature).toStringWithDegreeSymbol())."
        }
        
        return WeatherPressureAndHumidityModel(measurement: measurement,
                                               pressure: pressure,
                                               units: units,
                                               humidity: humidity,
                                               dewPoint: dewPoint)
    }
}
