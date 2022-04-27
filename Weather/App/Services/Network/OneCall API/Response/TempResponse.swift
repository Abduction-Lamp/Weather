//
//  TempResponse.swift
//  Weather
//
//  Created by Владимир on 25.04.2022.
//

import Foundation

struct TempResponse: Decodable {
    let morn: Double        // Утренняя температура
    let day: Double         // Дневная температура
    let eve: Double         // Вечерняя температура
    let night: Double       // Ночная температура
    let min: Double         // Минимальная дневная температура
    let max: Double         // Максимальная дневная температура
}
