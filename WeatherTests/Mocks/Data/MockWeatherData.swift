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
    let data:    Data
    
    
    init() {
        let builder = BuilderMockOneCallResponseComponents()
        
        weather = OneCallResponse(lat: 1.0,
                                  lon: 1.0,
                                  timezone: "Timezone",
                                  timezoneOffset: TimeInterval(1.0),
                                  current:  builder.buildCurrentResponse(),
                                  minutely: builder.buildMinutelyResponse(),
                                  hourly:   builder.buildHourlyResponse(),
                                  daily:    builder.buildDailyResponse(),
                                  alerts:   builder.buildAlertsResponse())
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        data = try! encoder.encode(weather)
    }
}


class BuilderMockOneCallResponseComponents {
    
    let times: [TimeInterval] = [
        TimeInterval(3600.0 * 1),        //  01:00:00
        TimeInterval(3600.0 * 2),        //  02:00:00
        TimeInterval(3600.0 * 3),        //  03:00:00
        TimeInterval(3600.0 * 4),        //  04:00:00
        TimeInterval(3600.0 * 5),        //  05:00:00
        TimeInterval(3600.0 * 6),        //  06:00:00
        TimeInterval(3600.0 * 7),        //  07:00:00
        TimeInterval(3600.0 * 8),        //  08:00:00
        TimeInterval(3600.0 * 9),        //  09:00:00
        TimeInterval(3600.0 * 10),       //  10:00:00
        TimeInterval(3600.0 * 11),       //  11:00:00
        TimeInterval(3600.0 * 12),       //  12:00:00
        TimeInterval(3600.0 * 13),       //  13:00:00
        TimeInterval(3600.0 * 14),       //  14:00:00
        TimeInterval(3600.0 * 15),       //  15:00:00
        TimeInterval(3600.0 * 16),       //  16:00:00
        TimeInterval(3600.0 * 17),       //  17:00:00
        TimeInterval(3600.0 * 18),       //  18:00:00
        TimeInterval(3600.0 * 19),       //  19:00:00
        TimeInterval(3600.0 * 20),       //  20:00:00
        TimeInterval(3600.0 * 21),       //  21:00:00
        TimeInterval(3600.0 * 22),       //  22:00:00
        TimeInterval(3600.0 * 23),       //  23:00:00
        TimeInterval(3600.0 * 24)        //  24:00:00
    ]
    
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
            WeatherResponse(id: 1, main: "Main", description: "Description", icon: "Icon")
        ]
    }
    
    func buildCurrentResponse() -> CurrentResponse {
        return CurrentResponse(time: times[0],
                               sunrise: times[1],
                               sunset: times[2],
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
            MinutelyResponse(time: times[0] + TimeInterval(60.0), precipitation: 1),
            MinutelyResponse(time: times[0] + TimeInterval(120.0), precipitation: 2)
        ]
    }
    
    func buildHourlyResponse() -> [HourlyResponse] {
        var hourly: [HourlyResponse] = []
        for index in 0 ... 2 {
            hourly.append(HourlyResponse(time: times[index],
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
                                         weather: buildWeatherResponse()))
        }
        return hourly
    }
    
    func buildDailyResponse() -> [DailyResponse] {
        var daily: [DailyResponse] = []
        for index in 0 ... 6 {
            let multi: TimeInterval = Double(index) * times[23]
            daily.append(DailyResponse(time:     times[0] + multi,
                                       sunrise:  times[1] + multi,
                                       sunset:   times[2] + multi,
                                       moonrise: times[3] + multi,
                                       moonset:  times[4] + multi,
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
                                       weather: buildWeatherResponse()))
        }
        
        return daily
    }
    
    func buildAlertsResponse() -> [AlertsResponse] {
        return [
            AlertsResponse(sender: "Sender",
                           event: "Event",
                           start: times[1],
                           end: times[2],
                           description: "Description",
                           tags: ["Tag1", "Tag2", "Tag3"])
        ]
    }
}
