//
//  WeatherAirPollutionModel.swift
//  Weather
//
//  Created by Владимир on 23.10.2022.
//

import Foundation

struct WeatherAirPollutionModel {
    /// Air quality index
    let aqi: Int
    
    let co:    Double?  // Концентрация CO (Оксид углерода), мкг/м3
    let no:    Double?  // Концентрация NO (Оксид азота), мкг/м3
    let no2:   Double?  // Концентрация NO2 (Диоксида азота), мкг/м3
    let o3:    Double?  // Концентрация О3 (Озон), мкг/м3
    let so2:   Double?  // Концентрация SO2 (Диоксид серы), мкг/м3
    let pm2_5: Double?  // Концентрация PM2.5 (Мелкие частицы), мкг/м3
    let pm10:  Double?  // Концентрация PM10 (Крупные частицы), мкг/м3
    let nh3:   Double?  // Концентрация NH3 (Аммиак), мкг/м3
}
