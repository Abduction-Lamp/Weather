//
//  CityData.swift
//  Weather
//
//  Created by Владимир on 13.04.2022.
//

import Foundation

struct CityData: Codable {
    let eng: String
    let rus: String
    let latitude: Double
    let longitude: Double
}


extension CityData: Equatable {
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        (lhs.eng == rhs.eng) && (lhs.rus == rhs.rus) && (lhs.latitude == rhs.latitude) && (lhs.longitude == rhs.longitude)
    }
}
