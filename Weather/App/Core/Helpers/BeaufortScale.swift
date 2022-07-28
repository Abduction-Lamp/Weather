//
//  BeaufortScale.swift
//  Weather
//
//  Created by Владимир on 26.05.2022.
//

import Foundation

///
/// Шкала Бофорта
///
enum BeaufortScale {
    case calm, air, light, gentle, moderate, fresh, strong, high, gale, severe, storm, violent, hurricane, indefinite
    
    init(speed: Double) {
        switch speed {
        case 0 ..< 0.21:               self = .calm
        case 0.21 ..< 1.5:             self = .air
        case 1.5 ..< 3.3:              self = .light
        case 3.3 ..< 5.4:              self = .gentle
        case 5.4 ..< 7.9:              self = .moderate
        case 7.9 ..< 10.7:             self = .fresh
        case 10.7 ..< 13.8:            self = .strong
        case 13.8 ..< 17.1:            self = .high
        case 17.1 ..< 20.7:            self = .gale
        case 20.7 ..< 24.4:            self = .severe
        case 24.4 ..< 28.4:            self = .storm
        case 28.4 ..< 32.6:            self = .violent
        case 32.6 ..< Double.infinity: self = .hurricane
        default:                       self = .indefinite
        }
    }
}


extension BeaufortScale: CustomStringConvertible {
    
    var description: String {
        switch self {
        case .calm:      return NSLocalizedString("BeaufortScale.calm"      , comment: "Calm")
        case .air:       return NSLocalizedString("BeaufortScale.air"       , comment: "Light air")
        case .light:     return NSLocalizedString("BeaufortScale.light"     , comment: "Light breeze")
        case .gentle:    return NSLocalizedString("BeaufortScale.gentle"    , comment: "Gentle breeze")
        case .moderate:  return NSLocalizedString("BeaufortScale.moderate"  , comment: "Moderate breeze")
        case .fresh:     return NSLocalizedString("BeaufortScale.fresh"     , comment: "Fresh breeze")
        case .strong:    return NSLocalizedString("BeaufortScale.strong"    , comment: "Strong breeze")
        case .high:      return NSLocalizedString("BeaufortScale.high"      , comment: "High wind")
        case .gale:      return NSLocalizedString("BeaufortScale.gale"      , comment: "Gale")
        case .severe:    return NSLocalizedString("BeaufortScale.severe"    , comment: "Strong gale")
        case .storm:     return NSLocalizedString("BeaufortScale.storm"     , comment: "Storm")
        case .violent:   return NSLocalizedString("BeaufortScale.violent"   , comment: "Violent storm")
        case .hurricane: return NSLocalizedString("BeaufortScale.hurricane" , comment: "Hurricane force")
        default:         return ""
        }
    }
}
