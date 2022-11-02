//
//  AirPollutionResponse.swift
//  Weather
//
//  Created by Владимир on 18.10.2022.
//

import Foundation

struct AirPollutionResponse: Codable {
    
    let coord: CoordinatesResponse
    let list: [AirPollutionItemResponse]

    private enum CodingKeys: String, CodingKey {
        case coord, list
    }
    
    struct CoordinatesResponse: Codable, Equatable {
        let lat: Double         // Географические координаты местоположения (широта)
        let lon: Double         // Географические координаты местоположения (долгота)
        
        private enum CodingKeys: String, CodingKey {
            case lat, lon
        }
        
        static func == (lhs: CoordinatesResponse, rhs: CoordinatesResponse) -> Bool {
            (lhs.lat == rhs.lat) && (lhs.lon == rhs.lon)
        }
    }
}


extension AirPollutionResponse: Equatable {
    
    static func == (lhs: AirPollutionResponse, rhs: AirPollutionResponse) -> Bool {
        if lhs.coord != rhs.coord {
            return false
        }
        if lhs.list.count == rhs.list.count {
            for index in 0 ..< lhs.list.count {
                if lhs.list[index] != rhs.list[index] {
                    return false
                }
            }
        } else {
            return false
        }
        return true
    }
}
