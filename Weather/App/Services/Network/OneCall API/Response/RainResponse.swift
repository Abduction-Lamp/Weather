//
//  RainResponse.swift
//  Weather
//
//  Created by Владимир on 25.04.2022.
//

import Foundation

struct RainResponse: Codable {
    let lastOneHour: Double        // Количество дождя за последний час, мм
    
    private enum CodingKeys: String, CodingKey {
        case lastOneHour = "1h"
    }
}


extension RainResponse: Equatable {
    
    static func == (lhs: RainResponse, rhs: RainResponse) -> Bool {
        lhs.lastOneHour == rhs.lastOneHour
    }
}
