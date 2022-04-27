//
//  GeocodingResponse.swift
//  Weather
//
//  Created by Владимир on 25.04.2022.
//

import Foundation

struct GeocodingResponse: Decodable {
    let name: String
    let localNames: LocalNames?
    let country: String
    let state: String?
    let lat: Double
    let lon: Double
    
    private enum CodingKeys: String, CodingKey {
        case name
        case localNames = "local_names"
        case country
        case state
        case lat
        case lon
    }
    
    
    struct LocalNames: Decodable {
        let featureName: String?
        let ascii: String?
        let ru: String?
        let en: String?
        
        private enum CodingKeys: String, CodingKey {
            case featureName = "feature_name"
            case ascii
            case ru
            case en
        }
    }
}
