//
//  GeocodingRequest.swift
//  Weather
//
//  Created by Владимир on 25.04.2022.
//

import Foundation

struct GeocodingRequest: BaseRequest {
    /// Abstruct
    let path: String = "/geo/1.0/direct"
    
    /// Request
    let сity: String
    let limit: Int = 5

    /// - Parameter appid: API key -- Обязательный параметр
    var params: [URLQueryItem] {
        return [
            URLQueryItem(name: "q", value: "\(сity)"),
            URLQueryItem(name: "limit", value: "\(limit)"),
            URLQueryItem(name: "appid", value: key)
        ]
    }
}
