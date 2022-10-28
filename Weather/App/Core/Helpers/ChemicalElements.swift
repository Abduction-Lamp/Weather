//
//  ChemicalElements.swift
//  Weather
//
//  Created by Владимир on 28.10.2022.
//

import Foundation

///
/// - Parameter co:    CO (Оксид углерода)
/// - Parameter no:    NO (Оксид азота)
/// - Parameter no2:   NO2 (Диоксида азота)
/// - Parameter o3:    О3 (Озон)
/// - Parameter so2:   SO2 (Диоксид серы)
/// - Parameter pm2_5: PM2.5 (Мелкие частицы)
/// - Parameter pm10:  PM10 (Крупные частицы)
/// - Parameter nh3:   NH3 (Аммиак)
///
enum ChemicalElements: CustomStringConvertible {
    case co(Double)
    case no(Double)
    case no2(Double)
    case o3(Double)
    case so2(Double)
    case pm2_5(Double)
    case pm10(Double)
    case nh3(Double)
    
    var value: Double {
        switch self {
        case let .co(value):    return value
        case let .no(value):    return value
        case let .no2(value):   return value
        case let .o3(value):    return value
        case let .so2(value):   return value
        case let .pm2_5(value): return value
        case let .pm10(value):  return value
        case let .nh3(value):   return value
        }
    }
    
    var designation: String {
        switch self {
        case .co:    return "CO"
        case .no:    return "NO"
        case .no2:   return "NO\u{2082}"
        case .o3:    return "O\u{2083}"
        case .so2:   return "SO\u{2082}"
        case .pm2_5: return "PM\u{2082}\u{2085}"
        case .pm10:  return "PM\u{2081}\u{2080}"
        case .nh3:   return "NH\u{2083}"
        }
    }
    
    var description: String {
        switch self {
        case .co:    return NSLocalizedString("AirIndicatorView.co",    comment: "CO")
        case .no:    return NSLocalizedString("AirIndicatorView.no",    comment: "NO")
        case .no2:   return NSLocalizedString("AirIndicatorView.no2",   comment: "NO2")
        case .o3:    return NSLocalizedString("AirIndicatorView.o3",    comment: "O3")
        case .so2:   return NSLocalizedString("AirIndicatorView.so2",   comment: "SO2")
        case .pm2_5: return NSLocalizedString("AirIndicatorView.pm2_5", comment: "PM2.5")
        case .pm10:  return NSLocalizedString("AirIndicatorView.pm10",  comment: "PM10")
        case .nh3:   return NSLocalizedString("AirIndicatorView.nh3",   comment: "NH3")
        }
    }
}
