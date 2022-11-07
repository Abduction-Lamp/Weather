//
//  MockWeatherModels.swift
//  WeatherTests
//
//  Created by Владимир on 02.11.2022.
//

import Foundation
@testable import Weather


class MockWeatherModels {
    
    let header: WeatherCityHeaderModel
    let hourly: [WeatherHourlyModel]
    let daily: [WeatherDailyModel]
    let wind: WeatherWindModel
    let pressure: WeatherPressureAndHumidityModel
    let air: WeatherAirPollutionModel
    
    init() {
        header   = BuilderWeatherModels.init().buildWeatherCityHeaderModel()
        hourly   = BuilderWeatherModels.init().buildWeatherHourlyModel()
        daily    = BuilderWeatherModels.init().buildWeatherDailyModel()
        wind     = BuilderWeatherModels.init().buildWeatherWindModel()
        pressure = BuilderWeatherModels.init().buildWeatherPressureAndHumidityModel()
        air      = BuilderWeatherModels.init().buildWeatherAirPollutionModel()
    }
}


class BuilderWeatherModels {

    func buildWeatherCityHeaderModel() -> WeatherCityHeaderModel {
        let city = "Москва 1.0"
        let temperature = "+37\u{00B0}"
        let description = "Description"
        
        return WeatherCityHeaderModel(city: city, temperature: temperature, description: description)
    }
    
    func buildWeatherHourlyModel() -> [WeatherHourlyModel] {
        return [
            WeatherHourlyModel(time: "Сейчас",
                               icon: IconService.shared.fetch(conditions: 1),
                               temperature: "+37\u{00B0}"),
            WeatherHourlyModel(time: "02",
                               icon: IconService.shared.fetch(conditions: 1),
                               temperature: "+37\u{00B0}"),
            WeatherHourlyModel(time: "02:00",
                               icon: IconService.shared.fetch(conditions: 1000),
                               temperature: "Восход солнца"),
            WeatherHourlyModel(time: "03",
                               icon: IconService.shared.fetch(conditions: 1),
                               temperature: "+37\u{00B0}"),
            WeatherHourlyModel(time: "03:00",
                               icon: IconService.shared.fetch(conditions: 1001),
                               temperature: "Заход солнца")
        ]
    }
    
    func buildWeatherDailyModel() -> [WeatherDailyModel] {
        let icons = IconService.shared
        let times = MockWeatherData.init().weather.daily!
        return [ 
            WeatherDailyModel(day: times[0].time.toStringLocolTime(offset: TimeInterval(1.0), format: "E.,  d MMM"),
                              icon: icons.fetch(conditions: 1, time: 1, sunrise: 1, sunset: 1),
                              temperature: "+37\u{00B0}" + " ... " + "+37\u{00B0}"),
            WeatherDailyModel(day: times[1].time.toStringLocolTime(offset: TimeInterval(1.0), format: "E.,  d MMM"),
                              icon: icons.fetch(conditions: 1, time: 1, sunrise: 1, sunset: 1),
                              temperature: "+37\u{00B0}" + " ... " + "+37\u{00B0}"),
            WeatherDailyModel(day: times[2].time.toStringLocolTime(offset: TimeInterval(1.0), format: "E.,  d MMM"),
                              icon: icons.fetch(conditions: 1, time: 1, sunrise: 1, sunset: 1),
                              temperature: "+37\u{00B0}" + " ... " + "+37\u{00B0}"),
            WeatherDailyModel(day: times[3].time.toStringLocolTime(offset: TimeInterval(1.0), format: "E.,  d MMM"),
                              icon: icons.fetch(conditions: 1, time: 1, sunrise: 1, sunset: 1),
                              temperature: "+37\u{00B0}" + " ... " + "+37\u{00B0}"),
            WeatherDailyModel(day: times[4].time.toStringLocolTime(offset: TimeInterval(1.0), format: "E.,  d MMM"),
                              icon: icons.fetch(conditions: 1, time: 1, sunrise: 1, sunset: 1),
                              temperature: "+37\u{00B0}" + " ... " + "+37\u{00B0}"),
            WeatherDailyModel(day: times[5].time.toStringLocolTime(offset: TimeInterval(1.0), format: "E.,  d MMM"),
                              icon: icons.fetch(conditions: 1, time: 1, sunrise: 1, sunset: 1),
                              temperature: "+37\u{00B0}" + " ... " + "+37\u{00B0}"),
            WeatherDailyModel(day: times[6].time.toStringLocolTime(offset: TimeInterval(1.0), format: "E.,  d MMM"),
                              icon: icons.fetch(conditions: 1, time: 1, sunrise: 1, sunset: 1),
                              temperature: "+37\u{00B0}" + " ... " + "+37\u{00B0}")
        ]
    }
    
    func buildWeatherWindModel() -> WeatherWindModel {
        let weather = MockWeatherData.init().weather
        let units: WindSpeedUnits = .kmh
        let measurement: String = String(format: "%.0f", weather.current!.windSpeed.toWindSpeed(in: units))
        let info: String = "Ураган, СВ\nСкорасть ветра 133 км/ч"
        return WeatherWindModel(measurement: measurement,
                                degrees: weather.current!.windDeg,
                                units: units.description, info: info)
    }
        
    func buildWeatherPressureAndHumidityModel() -> WeatherPressureAndHumidityModel {
        return WeatherPressureAndHumidityModel(measurement: "37", pressure: 37, units: "гПа", humidity: "37 %", dewPoint: "Точка росы\nСейчас: +37°.")
    }
            
    func buildWeatherAirPollutionModel() -> WeatherAirPollutionModel {
        let components = BuilderMockAirPollutionResponse.init().buildAirComponents_All()
        
        return WeatherAirPollutionModel(aqi: 1,
                                        co: components.co,
                                        no: components.no,
                                        no2: components.no2,
                                        o3: components.o3,
                                        so2: components.so2,
                                        pm2_5: components.pm2_5,
                                        pm10: components.pm10,
                                        nh3: components.nh3)
    }
}
