//
//  MockWeatherData.swift
//  WeatherTests
//
//  Created by Владимир on 05.10.2022.
//

import Foundation
@testable import Weather


class MockWeatherData {
    
    let weather: OneCallResponse
    let data: Data
    
    init() {
        let builder = MockOneCallResponseComponents()
        
        weather = OneCallResponse(lat: 1.0,
                                  lon: 1.0,
                                  timezone: "Timezone",
                                  timezoneOffset: TimeInterval(1.0),
                                  current: builder.buildCurrentResponse(),
                                  minutely: builder.buildMinutelyResponse(),
                                  hourly: builder.buildHourlyResponse(),
                                  daily: builder.buildDailyResponse(),
                                  alerts: builder.buildAlertsResponse())
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        data = try! encoder.encode(weather)
    }
}



class MockOneCallResponseComponents {
    
    func buildRainResponse() -> RainResponse {
        return RainResponse(lastOneHour: 1.0)
    }
    
    func buildSnowResponse() -> SnowResponse {
        return SnowResponse(lastOneHour: 1.0)
    }
    
    func buildTempResponse() -> TempResponse {
        return TempResponse(morn: 37.0, day: 37.0, eve: 37.0, night: 37.0, min: 37.0, max: 37.0)
    }
    
    func buildFeelsLikeResponse() -> FeelsLikeResponse {
        return FeelsLikeResponse(morn: 37.0, day: 37.0, eve: 37.0, night: 37.0)
    }
    
    func buildWeatherResponse() -> [WeatherResponse] {
        return [
            WeatherResponse(id: 1, main: "Main", description: "Description", icon: "Icon"),
            WeatherResponse(id: 2, main: "Main", description: "Description", icon: "Icon")
        ]
    }
    
    func buildCurrentResponse() -> CurrentResponse {
        return CurrentResponse(time: TimeInterval(1.0),
                               sunrise: TimeInterval(1.0),
                               sunset: TimeInterval(1.0),
                               temp: 37.0,
                               feelsLike: 37.0,
                               pressure: 37,
                               humidity: 37,
                               dewPoint: 37.0,
                               clouds: 37,
                               uvi: 37.0,
                               visibility: 37,
                               windSpeed: 37.0,
                               windGust: 37.0,
                               windDeg: 37,
                               rain: buildRainResponse(),
                               snow: buildSnowResponse(),
                               weather: buildWeatherResponse())
    }
    
    func buildMinutelyResponse() -> [MinutelyResponse] {
        return [
            MinutelyResponse(time: TimeInterval(1.0), precipitation: 1),
            MinutelyResponse(time: TimeInterval(2.0), precipitation: 2)
        ]
    }
    
    func buildHourlyResponse() -> [HourlyResponse] {
        return [
            HourlyResponse(time: TimeInterval(1.0),
                           temp: 37.0,
                           feelsLike: 37.0,
                           pressure: 37,
                           humidity: 37,
                           dewPoint: 37.0,
                           uvi: 37.0,
                           clouds: 37,
                           visibility: 37,
                           windSpeed: 1.0,
                           windGust: 1.0,
                           windDeg: 1,
                           pop: 1.0,
                           rain: buildRainResponse(),
                           snow: nil,
                           weather: buildWeatherResponse())
        ]
    }
    
    func buildDailyResponse() -> [DailyResponse] {
        return [
            DailyResponse(time: TimeInterval(1.0),
                          sunrise: TimeInterval(1.0),
                          sunset: TimeInterval(1.0),
                          moonrise: TimeInterval(1.0),
                          moonset: TimeInterval(1.0),
                          moonPhase: 1.0,
                          temp: buildTempResponse(),
                          feelsLike: buildFeelsLikeResponse(),
                          pressure: 1,
                          humidity: 1,
                          dewPoint: 1.0,
                          windSpeed: 1.0,
                          windGust: 1.0,
                          windDeg: 1,
                          uvi: 1.0,
                          clouds: 1,
                          pop: 1.0,
                          rain: 1.0,
                          snow: nil,
                          weather: buildWeatherResponse())
        ]
    }
    
    func buildAlertsResponse() -> [AlertsResponse] {
        return [
            AlertsResponse(sender: "Sender",
                           event: "Event",
                           start: TimeInterval(1.0),
                           end: TimeInterval(1.0),
                           description: "Description",
                           tags: ["Tag1", "Tag2", "Tag3"])
        ]
    }
}
