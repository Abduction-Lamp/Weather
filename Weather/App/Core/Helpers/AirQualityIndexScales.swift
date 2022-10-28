//
//  AirQualityIndexScales.swift
//  Weather
//
//  Created by Владимир on 26.10.2022.
//

import UIKit

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


// MARK: Europe Common Air Quality Index (CAQI)
//
//                          NO2         O3          PM2.5       PM10
// Very low  = Good         0–50        0–60        0–15        0–25
// Low       = Fair         50–100      60–120      15–30       25–50
// Medium    = Moderate     100–200     120–180     30–55       50–90
// High      = Poor         200–400     180–240     55–110      90–180
// Very high = Very Poor    >400        >240        >110        >180
//
enum CAQIEuropeScale: Int, CustomStringConvertible {
    case good = 1, fair = 2, moderate = 3, poor = 4, veryPoor = 5, indefinite = 0
    
    init(for element: ChemicalElements) {
        switch element {
        case let .no2(value):
            switch value {
            case 0   ..< 50:  self = .good
            case 50  ..< 100: self = .fair
            case 100 ..< 200: self = .moderate
            case 200 ..< 400: self = .poor
            default:          self = .veryPoor
            }
        case let .o3(value):
            switch value {
            case 0   ..< 60:  self = .good
            case 60  ..< 120: self = .fair
            case 120 ..< 180: self = .moderate
            case 180 ..< 240: self = .poor
            default:          self = .veryPoor
            }
        case let .pm2_5(value):
            switch value {
            case 0  ..< 15:  self = .good
            case 15 ..< 30:  self = .fair
            case 30 ..< 55:  self = .moderate
            case 55 ..< 110: self = .poor
            default:         self = .veryPoor
            }
        case let .pm10(value):
            switch value {
            case 0  ..< 25:  self = .good
            case 25 ..< 50:  self = .fair
            case 50 ..< 90:  self = .moderate
            case 90 ..< 180: self = .poor
            default:         self = .veryPoor
            }
        default: self = .indefinite
        }
    }
    
    var description: String {
        switch self {
        case .good:       return NSLocalizedString("AirIndicatorView.Good",     comment: "Good")
        case .fair:       return NSLocalizedString("AirIndicatorView.Fair",     comment: "Fair")
        case .moderate:   return NSLocalizedString("AirIndicatorView.Moderate", comment: "Moderate")
        case .poor:       return NSLocalizedString("AirIndicatorView.Poor",     comment: "Poor")
        case .veryPoor:   return NSLocalizedString("AirIndicatorView.VeryPoor", comment: "Very Poor")
        case .indefinite: return "-"
        }
    }
    
    func getColor() -> UIColor {
        switch self {
        case .good:       return .systemGreen
        case .fair:       return .systemYellow
        case .moderate:   return .systemOrange
        case .poor:       return .systemRed
        case .veryPoor:   return .systemPurple
        case .indefinite: return .clear
        }
    }
}



// MARK: India Air Quality Index (AQI)
//
//                 (Range)     PM10      PM2.5     NO2       O3        CO        SO2        NH3         Pb        Colour
//  Good           (0–50)      0–50      0–30      0–40      0–50      0–1.0     0–40       0–200       0–0.5     Deep Green
//  Satisfactory   (51–100)    51–100    31–60     41–80     51–100    1.1–2.0   41–80      201–400     0.5–1.0   Light Green
//  Moderate       (101–200)   101–250   61–90     81–180    101–168   2.1–10    81–380     401–800     1.1–2.0   Yellow
//  Poor           (201–300)   251–350   91–120    181–280   169–208   10–17     381–800    801–1200    2.1–3.0   Orange
//  Very Poor      (301–400)   351–430   121–250   281–400   209–748   17–34     801–1600   1200–1800   3.1–3.5   Red
//  Severe         (401-500)   430+      250+      400+      748+      34+       1600+      1800+       3.5+      Maroon
//
enum AQIIndiaScale: CustomStringConvertible {
    case good, satisfactory, moderate, poor, veryPoor, severe, indefinite
    
    init(for element: ChemicalElements) {
        switch element {
        case let .pm10(value):
            switch value {
            case 0   ..< 50:  self = .good
            case 50  ..< 100: self = .satisfactory
            case 100 ..< 250: self = .moderate
            case 250 ..< 350: self = .poor
            case 350 ..< 430: self = .veryPoor
            default:          self = .severe
            }
        case let .pm2_5(value):
            switch value {
            case 0   ..< 30:  self = .good
            case 30  ..< 60:  self = .satisfactory
            case 60  ..< 90:  self = .moderate
            case 90  ..< 120: self = .poor
            case 120 ..< 250: self = .veryPoor
            default:          self = .severe
            }
        case let .no2(value):
            switch value {
            case 0   ..< 40:  self = .good
            case 40  ..< 80:  self = .satisfactory
            case 80  ..< 180: self = .moderate
            case 180 ..< 280: self = .poor
            case 280 ..< 400: self = .veryPoor
            default:          self = .severe
            }
        case let .o3(value):
            switch value {
            case 0   ..< 50:  self = .good
            case 50  ..< 100: self = .satisfactory
            case 100 ..< 168: self = .moderate
            case 168 ..< 208: self = .poor
            case 208 ..< 748: self = .veryPoor
            default:          self = .severe
            }
        case let .co(value):
            switch value {
            case 0  ..< 1:  self = .good
            case 1  ..< 2:  self = .satisfactory
            case 2  ..< 10: self = .moderate
            case 10 ..< 17: self = .poor
            case 17 ..< 34: self = .veryPoor
            default:        self = .severe
            }
        case let .so2(value):
            switch value {
            case 0  ..< 40:    self = .good
            case 40  ..< 80:   self = .satisfactory
            case 80  ..< 380:  self = .moderate
            case 380 ..< 800:  self = .poor
            case 800 ..< 1600: self = .veryPoor
            default:           self = .severe
            }
        case let .nh3(value):
            switch value {
            case 0    ..< 200:  self = .good
            case 200  ..< 400:  self = .satisfactory
            case 400  ..< 800:  self = .moderate
            case 800  ..< 1200: self = .poor
            case 1200 ..< 1800: self = .veryPoor
            default:            self = .severe
            }
        default: self = .indefinite
        }
    }
    
    func getColor() -> UIColor {
        switch self {
        case .good:         return .systemGreen
        case .satisfactory: return .systemYellow
        case .moderate:     return .systemOrange
        case .poor:         return .systemRed
        case .veryPoor:     return .systemPurple
        case .severe:       return .systemBrown
        case .indefinite:   return .clear
        }
    }
    
    var description: String {
        switch self {
        case .good:         return NSLocalizedString("AirIndicatorView.Good",     comment: "Good")
        case .satisfactory: return NSLocalizedString("AirIndicatorView.Fair",     comment: "Fair")
        case .moderate:     return NSLocalizedString("AirIndicatorView.Moderate", comment: "Moderate")
        case .poor:         return NSLocalizedString("AirIndicatorView.Poor",     comment: "Poor")
        case .veryPoor:     return NSLocalizedString("AirIndicatorView.VeryPoor", comment: "Very Poor")
        case .severe:       return NSLocalizedString("AirIndicatorView.Severe",   comment: "Severe")
        case .indefinite:   return "-"
        }
    }
}
