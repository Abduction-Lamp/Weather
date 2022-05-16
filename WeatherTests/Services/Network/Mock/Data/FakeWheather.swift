//
//  FakeWheather.swift
//  WeatherTests
//
//  Created by Владимир on 12.05.2022.
//

import Foundation
@testable import Weather


struct FakeWheather {
    
    private let weatherResponseArray: [WeatherResponse]
    private let weatherCurrentResponse: CurrentResponse
    private let minutelyResponse: [MinutelyResponse]
    private let hourlyResponse: [HourlyResponse]
    private let dailyResponse: [DailyResponse]
    private let alertsResponse: [AlertsResponse]
    
    
    let weather: OneCallResponse
    let data: Data
    
    
    init() {
        weatherResponseArray = [
            WeatherResponse(id: 1, main: "main", description: "description", icon: "icon"),
            WeatherResponse(id: 2, main: "main", description: "description", icon: "icon")
        ]
        
        weatherCurrentResponse = CurrentResponse(time: TimeInterval(1.0),
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
                                                 windSpeed: 1.0,
                                                 windGust: 1.0,
                                                 windDeg: 1,
                                                 rain: RainResponse(lastOneHour: 1.0),
                                                 snow: nil,
                                                 weather: weatherResponseArray)
        
        minutelyResponse = [
            MinutelyResponse(time: TimeInterval(1.0), precipitation: 1),
            MinutelyResponse(time: TimeInterval(2.0), precipitation: 2)
        ]
        
        hourlyResponse = [
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
                           rain: RainResponse(lastOneHour: 1.0),
                           snow: nil,
                           weather: weatherResponseArray)
        ]
        
        dailyResponse = [
            DailyResponse(time: TimeInterval(1.0),
                          sunrise: TimeInterval(1.0),
                          sunset: TimeInterval(1.0),
                          moonrise: TimeInterval(1.0),
                          moonset: TimeInterval(1.0),
                          moonPhase: 1.0,
                          temp: TempResponse(morn: 1.0, day: 1.0, eve: 1.0, night: 1.0, min: 1.0, max: 1.0),
                          feelsLike: FeelsLikeResponse(morn: 1.0, day: 1.0, eve: 1.0, night: 1.0),
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
                          weather: weatherResponseArray)
        ]
        
        alertsResponse = [
            AlertsResponse(sender: "sender",
                           event: "event",
                           start: TimeInterval(1.0),
                           end: TimeInterval(1.0),
                           description: "description",
                           tags: ["tags"])
        ]

        weather = OneCallResponse(lat: 1.0,
                                  lon: 1.0,
                                  timezone: "timezone",
                                  timezoneOffset: TimeInterval(1.0),
                                  current: weatherCurrentResponse,
                                  minutely: minutelyResponse,
                                  hourly: hourlyResponse,
                                  daily: dailyResponse,
                                  alerts: alertsResponse)
        

        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        data = try! encoder.encode(weather)
    }
}
