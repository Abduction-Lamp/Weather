//
//  AirPollutionRequest.swift
//  Weather
//
//  Created by Владимир on 18.10.2022.
//

import Foundation

struct AirPollutionRequest: BaseRequest {
    /// Abstruct
    let path: String = "/data/2.5/air_pollution"
    
    /// Request
    let lat: Double
    let lon: Double

    /// - Parameter appid: API key -- Обязательный параметр
    var params: [URLQueryItem] {
        return [
            URLQueryItem(name: "lat", value: "\(lat)"),
            URLQueryItem(name: "lon", value: "\(lon)"),
            URLQueryItem(name: "appid", value: key)
        ]
    }
}
