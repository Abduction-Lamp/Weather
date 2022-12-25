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
    
    func fetch()
    
    func getNumberOfSections() -> Int
    func getNumberOfAirComponents() -> Int
    
    func makeWeatherCityHeaderModel() -> WeatherCityHeaderModel
    func makeWeatherHourlyModel() -> [WeatherHourlyModel]
    func makeWeatherDailyModel() -> [WeatherDailyModel]
    func makeWeatherWindModel() -> WeatherWindModel
    func makeWeatherPressureAndHumidityModel() -> WeatherPressureAndHumidityModel
    func makeWeatherAirPollutionModel() -> WeatherAirPollutionModel?
}


class WeatherViewModel {
    var city: CityData?
    var statusDay = Bindable<TimeOfDay?>(nil)
    var state = Bindable<UIViewController.Mode>(.none)
    
    private var weather: OneCallResponse?
    private var air: AirPollutionResponse?
    
    private weak var settings: Settings?
    private weak var network: NetworkServiceProtocol?
    private var icons = IconService.shared
    
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
    public func fetch() {
        guard let city = city else { return }
        
        state.value = .loading
        
        let group = DispatchGroup()
        var mode: UIViewController.Mode = .none
        
        group.enter()
        network?.getWeather(lat: city.latitude,
                            lon: city.longitude,
                            units: "metric",
                            lang: NSLocalizedString("General.Lang", comment: "Lang")) { [weak self] response in
            defer { group.leave() }
            guard let self = self else { return }
            
            switch response {
            case .success(let result):
                self.weather = result
                if let time = result.current?.time,
                   let sunrise = result.current?.sunrise,
                   let sunset = result.current?.sunset {
                    self.statusDay.value = .init(time: time, sunrise: sunrise, sunset: sunset)
                }
                mode = .success(true)
            case .failure(let error):
                print(error)
                mode = .failure(error.description)
            }

        }
        
        group.enter()
        network?.getAirPollution(lat: city.latitude, lon: city.longitude) { [weak self] response in
            defer { group.leave() }
            guard let self = self else { return }
            
            switch response {
            case .success(let result):
                self.air = result
            case .failure:
                self.air = nil
            }
        }
        
        group.wait()
        state.value = mode
    }
    
    
    func getNumberOfSections() -> Int {
        var numberOfSections = 0
        
        if weather != nil { numberOfSections += 4 }
        if air != nil { numberOfSections += 1 }
        
        return numberOfSections
    }
    
    func getNumberOfAirComponents() -> Int {
        var count = 0
        if let _ = air?.list.first?.components.co    { count += 1 }
        if let _ = air?.list.first?.components.nh3   { count += 1 }
        if let _ = air?.list.first?.components.pm10  { count += 1 }
        if let _ = air?.list.first?.components.pm2_5 { count += 1 }
        if let _ = air?.list.first?.components.so2   { count += 1 }
        if let _ = air?.list.first?.components.o3    { count += 1 }
        if let _ = air?.list.first?.components.no2   { count += 1 }
        if let _ = air?.list.first?.components.no    { count += 1 }
        return count
    }
    
    
    // MARK: Make models
    //
    func makeWeatherCityHeaderModel() -> WeatherCityHeaderModel {
        guard let city = city else { return WeatherCityHeaderModel(city: "", temperature: "", description: "") }
        let cityName = city.getName(lang: NSLocalizedString("General.Lang", comment: "Lang"))
        let description = weather?.current?.weather.first?.description ?? ""
        var temperature: String = ""
        if let temp = weather?.current?.temp, let settings = settings {
            temperature = temp.toTemperature(in: settings.units.value.temperature).toStringWithDegreeSymbol()
        }
        return WeatherCityHeaderModel(city: cityName, temperature: temperature, description: description)
    }
    
    func makeWeatherHourlyModel() -> [WeatherHourlyModel] {
        var model: [WeatherHourlyModel] = []
        if let value = weather, let hourly = value.hourly, let settings = settings {
            let wordNow = NSLocalizedString("WeatherView.CommonWords.Now", comment: "Now")
            for (index, response) in hourly.enumerated() where index < 24 {
                let hour = response.time.toStringLocolTime(offset: value.timezoneOffset, format: "HH")
                let icon = icons.fetch(conditions: response.weather.first?.id,
                                       time: response.time,
                                       sunrise: value.current?.sunrise,
                                       sunset: value.current?.sunset)
                let temperature = response.temp.toTemperature(in: settings.units.value.temperature).toStringWithDegreeSymbol()
                
                model.append(WeatherHourlyModel(time: index == 0 ? wordNow : hour, icon: icon, temperature: temperature))
            }
            
            ///
            /// Вставка информации о sunrise и sunset
            ///
            if let sunrise = weather?.current?.sunrise, let sunset = weather?.current?.sunset {
                let timeSunrise = sunrise.toStringLocolTime(offset: value.timezoneOffset, format: "HH")
                if let sunriseIndex = model.firstIndex(where: { $0.time == timeSunrise }) {
                    let wordSunrise = NSLocalizedString("WeatherView.CommonWords.Sunrise", comment: "Sunrise")
                    let time = sunrise.toStringLocolTime(offset: value.timezoneOffset, format: "HH:mm")
                    let icon = icons.fetch(conditions: IconService.ExpandedIconSet.sunrise.rawValue)
                    
                    model.insert(WeatherHourlyModel(time: time, icon: icon, temperature: wordSunrise), at: sunriseIndex + 1)
                }
                
                let timeSunset = sunset.toStringLocolTime(offset: value.timezoneOffset, format: "HH")
                if let sunsetIndex = model.firstIndex(where: { $0.time == timeSunset }) {
                    let wordSunset = NSLocalizedString("WeatherView.CommonWords.Sunset", comment: "Sunset")
                    let time = sunset.toStringLocolTime(offset: value.timezoneOffset, format: "HH:mm")
                    let icon = icons.fetch(conditions: IconService.ExpandedIconSet.sunset.rawValue)
                    
                    model.insert(WeatherHourlyModel(time: time, icon: icon, temperature: wordSunset), at: sunsetIndex + 1)
                }
            }
        }
        return model
    }
    
    func makeWeatherDailyModel() -> [WeatherDailyModel] {
        var model: [WeatherDailyModel] = []
        if let value = weather, let daily = value.daily, let settings = settings {
            for (index, response) in daily.enumerated() {
                let day = response.time.toStringLocolTime(offset: value.timezoneOffset, format: "E.,  d MMM")
                let min = response.temp.min.toTemperature(in: settings.units.value.temperature).toStringWithDegreeSymbol()
                let max = response.temp.max.toTemperature(in: settings.units.value.temperature).toStringWithDegreeSymbol()
                let temperature = min + " ... " + max
                let wordToday = NSLocalizedString("WeatherView.CommonWords.Today", comment: "Today")
                let icon = icons.fetch(conditions: response.weather.first?.id)
                
                model.append(WeatherDailyModel(day: index == 0 ? wordToday : day, icon: icon, temperature: temperature))
            }
        }
        return model
    }
    
    func makeWeatherWindModel() -> WeatherWindModel {
        var measurement: String = ""
        var degrees: Int = 0
        let unitDesignation: String = settings?.units.value.windSpeed.description ?? ""
        var info: String = ""

        if let value = weather?.current, let settings = settings {
            let gustLocalWord = NSLocalizedString("WeatherView.CommonWords.GustWind", comment: "Gust Wind")
            let windLocalWord = NSLocalizedString("WeatherView.CommonWords.WindTitle", comment: "Wind")
            let windSpeedLocalWord = NSLocalizedString("WeatherView.CommonWords.WindSpeed", comment: "Wind Speed")
        
            let unit = settings.units.value.windSpeed
            let speed = value.windSpeed.toWindSpeed(in: unit).rounded(.toNearestOrAwayFromZero)

            measurement = String(format: "%.0f", speed)
            degrees = value.windDeg
    
            var gust = ""
            if let windGust = value.windGust, value.windSpeed < windGust {
                let gustSpeed = windGust.toWindSpeed(in: unit).rounded(.toNearestOrAwayFromZero)
                gust = gustLocalWord
                gust += String(format: "%.0f", gustSpeed)
                gust += " "
                gust += unitDesignation
            }
            
            var direction = ""
            let stringDirection = WindDirection.init(degrees).description
            if !stringDirection.isEmpty {
                direction = ", " + stringDirection
            }
            
            let measurementDescription = BeaufortScale.init(speed: value.windSpeed)
            switch measurementDescription {
            case .calm:
                info = measurementDescription.description
            case .air, .light, .gentle, .moderate, .fresh, .strong, .high, .gale, .severe:
                info = windLocalWord
                info += " "
                info += measurementDescription.description
                info += direction
                info += "\n"
                info += windSpeedLocalWord
                info += " "
                info += measurement
                info += " "
                info += unitDesignation
                info += gust
            case .storm, .violent, .hurricane:
                info = measurementDescription.description
                info += direction
                info += "\n"
                info += windSpeedLocalWord
                info += " "
                info += measurement
                info += " "
                info += unitDesignation
                info += gust
            case .indefinite:
                info = ""
            }
        }
        return WeatherWindModel(measurement: measurement, degrees: degrees, units: unitDesignation, info: info)
    }
    
    func makeWeatherPressureAndHumidityModel() -> WeatherPressureAndHumidityModel {
        var measurement: String = ""
        var pressure: Int = 0
        let unitDesignation: String = settings?.units.value.pressure.description ?? ""
        var humidity: String = ""
        var dewPoint: String = ""

        if let value = weather?.current, let settings = settings {
            measurement = value.pressure.toPressureToString(in: settings.units.value.pressure)
            pressure = value.pressure
            
            let wordNow = NSLocalizedString("WeatherView.CommonWords.Now", comment: "Now")
            let wordDewPoint = NSLocalizedString("WeatherView.CommonWords.DewPoint", comment: "Dew point")
            humidity = "\(value.humidity) %"
            dewPoint = wordDewPoint
            dewPoint += "\n"
            dewPoint += wordNow
            dewPoint += ": "
            dewPoint += value.dewPoint.toTemperature(in: settings.units.value.temperature).toStringWithDegreeSymbol()
            dewPoint += "."
        }
        
        return WeatherPressureAndHumidityModel(measurement: measurement,
                                               pressure: pressure,
                                               units: unitDesignation,
                                               humidity: humidity,
                                               dewPoint: dewPoint)
    }
    
    func makeWeatherAirPollutionModel() -> WeatherAirPollutionModel? {
        guard let now = air?.list.first else { return nil }
        return WeatherAirPollutionModel(response: now)
    }
}
