//
//  FeelsLikeResponse.swift
//  Weather
//
//  Created by Владимир on 25.04.2022.
//

import Foundation

struct FeelsLikeResponse: Decodable {
    let morn: Double    // Утренняя температура
    let day: Double     // Дневная температура
    let eve: Double     // Вечерняя температура
    let night: Double   // Ночная температура
}
