//
//  BaseRequest.swift
//  Weather
//
//  Created by Владимир on 25.04.2022.
//

import Foundation

protocol BaseRequest {
    var scheme: String { get }
    var host:   String { get }
    var path:   String { get }
    var params: [URLQueryItem] { get }
    
    var key:  String { get }
}

extension BaseRequest {
    
    var scheme: String {
        "https"
    }
    
    var host: String {
        "api.openweathermap.org"
    }
    
    var key: String {
        AppKeys.shared.api
    }
}
