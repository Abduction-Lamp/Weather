//
//  CityData.swift
//  Weather
//
//  Created by Владимир on 13.04.2022.
//

import Foundation

struct CityData: Codable {
    let city: String
    let rusName: String?
    let engName: String?
    let latitude: Double
    let longitude: Double
}


extension CityData: Equatable {
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.city == rhs.city
    }
}
