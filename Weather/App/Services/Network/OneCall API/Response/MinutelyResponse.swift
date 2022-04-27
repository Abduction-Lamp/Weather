//
//  MinutelyResponse.swift
//  Weather
//
//  Created by Владимир on 25.04.2022.
//

import Foundation

struct MinutelyResponse: Decodable {
    let time: TimeInterval      // Время прогнозируемых данных, unix, UTC
    let precipitation: Int      // Объем осадков, мм
    
    private enum CodingKeys: String, CodingKey {
        case time = "dt"
        case precipitation
    }
}
