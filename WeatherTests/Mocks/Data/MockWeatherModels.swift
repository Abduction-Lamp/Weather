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
        return [
            WeatherDailyModel(day: "1", icon: nil, temperature: "+37\u{00B0}" + " ... " + "+37\u{00B0}"),
            WeatherDailyModel(day: "2", icon: nil, temperature: "+37\u{00B0}" + " ... " + "+37\u{00B0}"),
            WeatherDailyModel(day: "3", icon: nil, temperature: "+37\u{00B0}" + " ... " + "+37\u{00B0}"),
            WeatherDailyModel(day: "4", icon: nil, temperature: "+37\u{00B0}" + " ... " + "+37\u{00B0}"),
            WeatherDailyModel(day: "5", icon: nil, temperature: "+37\u{00B0}" + " ... " + "+37\u{00B0}"),
            WeatherDailyModel(day: "6", icon: nil, temperature: "+37\u{00B0}" + " ... " + "+37\u{00B0}"),
            WeatherDailyModel(day: "7", icon: nil, temperature: "+37\u{00B0}" + " ... " + "+37\u{00B0}")
        ]
    }
    
    func buildWeatherWindModel() -> WeatherWindModel {
        return WeatherWindModel(measurement: "1", degrees: 1, units: "1", info: "1")
    }
        
    func buildWeatherPressureAndHumidityModel() -> WeatherPressureAndHumidityModel {
        return WeatherPressureAndHumidityModel(measurement: "1", pressure: 1, units: "1", humidity: "1", dewPoint: "1")
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
