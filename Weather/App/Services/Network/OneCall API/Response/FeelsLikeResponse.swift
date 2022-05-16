//
//  FeelsLikeResponse.swift
//  Weather
//
//  Created by Владимир on 25.04.2022.
//

import Foundation

struct FeelsLikeResponse: Codable {
    let morn: Double    // Утренняя температура
    let day: Double     // Дневная температура
    let eve: Double     // Вечерняя температура
    let night: Double   // Ночная температура
}


extension FeelsLikeResponse: Equatable {
    
    static func == (lhs: FeelsLikeResponse, rhs: FeelsLikeResponse) -> Bool {
        lhs.morn == rhs.morn &&
        lhs.day == rhs.day &&
        lhs.eve == rhs.eve &&
        lhs.night == rhs.night
    }
}
