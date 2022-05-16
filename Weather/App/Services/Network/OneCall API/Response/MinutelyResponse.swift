//
//  MinutelyResponse.swift
//  Weather
//
//  Created by Владимир on 25.04.2022.
//

import Foundation

struct MinutelyResponse: Codable {
    let time: TimeInterval      // Время прогнозируемых данных, unix, UTC
    let precipitation: Int      // Объем осадков, мм
    
    private enum CodingKeys: String, CodingKey {
        case time = "dt"
        case precipitation
    }
}


extension MinutelyResponse: Equatable {
    
    static func == (lhs: MinutelyResponse, rhs: MinutelyResponse) -> Bool {
        lhs.time == rhs.time &&
        lhs.precipitation == rhs.precipitation
    }
}
