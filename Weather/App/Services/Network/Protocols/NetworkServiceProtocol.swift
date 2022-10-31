//
//  NetworkServiceProtocol.swift
//  Weather
//
//  Created by Владимир on 31.10.2022.
//

import Foundation

protocol NetworkServiceProtocol: AnyObject {

    func getCoordinates(for city: String,
                        completed: @escaping (Result<[GeocodingResponse], NetworkErrors>) -> Void)
    
    func getWeather(lat: Double, lon: Double, units: String, lang: String,
                    completed: @escaping (Result<OneCallResponse, NetworkErrors>) -> Void)
    
    func getAirPollution(lat: Double, lon: Double,
                         completed: @escaping (Result<AirPollutionResponse, NetworkErrors>) -> Void)
}
