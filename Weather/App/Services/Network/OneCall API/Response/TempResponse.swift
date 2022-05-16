//
//  TempResponse.swift
//  Weather
//
//  Created by Владимир on 25.04.2022.
//

import Foundation

struct TempResponse: Codable {
    let morn: Double        // Утренняя температура
    let day: Double         // Дневная температура
    let eve: Double         // Вечерняя температура
    let night: Double       // Ночная температура
    let min: Double         // Минимальная дневная температура
    let max: Double         // Максимальная дневная температура
}


extension TempResponse: Equatable {
    
    static func == (lhs: TempResponse, rhs: TempResponse) -> Bool {
        lhs.morn == rhs.morn &&
        lhs.day == rhs.day &&
        lhs.eve == rhs.eve &&
        lhs.night == rhs.night &&
        lhs.min == rhs.min &&
        lhs.max == rhs.max
    }
}
