//
//  SnowResponse.swift
//  Weather
//
//  Created by Владимир on 25.04.2022.
//

import Foundation

struct SnowResponse: Decodable {
    let lastOneHour: Double        // Объем снега за последний час, мм
    
    private enum CodingKeys: String, CodingKey {
        case lastOneHour = "1h"
    }
}
