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
enum BeaufortScale: String {
    case calm       = "Штиль"
    case air        = "Тихий"
    case light      = "Лёгкий"
    case gentle     = "Слабый"
    case moderate   = "Умеренный"
    case fresh      = "Свежий"
    case strong     = "Сильный"
    case high       = "Крепкий"
    case gale       = "Очень крепкий"
    case severe     = "Шторм"
    case storm      = "Сильный шторм"
    case violent    = "Жестокий шторм"
    case hurricane  = "Ураган"
    case indefinite = ""
    
    init(speed: Double) {
        switch speed {
        case 0 ..< 0.21:
            self = .calm
        case 0.21 ..< 1.5:
            self = .air
        case 1.5 ..< 3.3:
            self = .light
        case 3.3 ..< 5.4:
            self = .gentle
        case 5.4 ..< 7.9:
            self = .moderate
        case 7.9 ..< 10.7:
            self = .fresh
        case 10.7 ..< 13.8:
            self = .strong
        case 13.8 ..< 17.1:
            self = .high
        case 17.1 ..< 20.7:
            self = .gale
        case 20.7 ..< 24.4:
            self = .severe
        case 24.4 ..< 28.4:
            self = .storm
        case 28.4 ..< 32.6:
            self = .violent
        case 32.6 ..< Double.infinity:
            self = .hurricane
        default:
            self = .indefinite
        }
    }
}
