//
//  SnowResponse.swift
//  Weather
//
//  Created by Владимир on 25.04.2022.
//

import Foundation

struct SnowResponse: Codable {
    let lastOneHour: Double        // Объем снега за последний час, мм
    
    private enum CodingKeys: String, CodingKey {
        case lastOneHour = "1h"
    }
}


extension SnowResponse: Equatable {
    
    static func == (lhs: SnowResponse, rhs: SnowResponse) -> Bool {
        lhs.lastOneHour == rhs.lastOneHour
    }
}
