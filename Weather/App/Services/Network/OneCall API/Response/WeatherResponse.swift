//
//  WeatherResponse.swift
//  Weather
//
//  Created by Владимир on 25.04.2022.
//

import Foundation

struct WeatherResponse: Decodable {
    let id: Int                 // Идентификатор состояния погоды
    let main: String            // Группа параметров погоды (дождь, снег, экстремальная погода и т.д.)
    let description: String     // Погодное условие, описание
    let icon: String            // Идентификатор (OpenWeather) значка погоды
}
