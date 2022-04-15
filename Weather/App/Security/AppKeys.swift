//
//  AppKeys.swift
//  Weather
//
//  Created by Владимир on 13.04.2022.
//

import Foundation

struct AppKeys {
    
    static let shared = AppKeys()
    private init() { }
    
    let api         = "58612e72ccc2f1de44f96cb33143e6ea"
    
    let settings    = "AppKeys.Weather.app.Settings"
    
    let cities      = "AppKeys.Weather.app.CitiesList"
    let temperature = "AppKeys.Weather.app.Settings.Unit.Temperature"
    let wind        = "AppKeys.Weather.app.Settings.Unit.WindSpeed"
    let pressure    = "AppKeys.Weather.app.Settings.Unit.Pressure"
}
