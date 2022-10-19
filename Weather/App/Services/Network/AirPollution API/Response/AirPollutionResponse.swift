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
    
    struct CoordinatesResponse: Codable {
        let lat: Double         // Географические координаты местоположения (широта)
        let lon: Double         // Географические координаты местоположения (долгота)
        
        private enum CodingKeys: String, CodingKey {
            case lat, lon
        }
    }
}
