//
//  RainResponse.swift
//  Weather
//
//  Created by Владимир on 25.04.2022.
//

import Foundation

struct RainResponse: Decodable {
    let lastOneHour: Double        // Количество дождя за последний час, мм
    
    private enum CodingKeys: String, CodingKey {
        case lastOneHour = "1h"
    }
}
