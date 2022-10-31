//
//  AirQualityIndexScales.swift
//  Weather
//
//  Created by Владимир on 26.10.2022.
//

import UIKit

// MARK: - Europe Common Air Quality Index (CAQI)
//
//                          NO2         O3          PM2.5       PM10        (Color)
// Very low  = Good         0–50        0–60        0–15        0–25        (Green)
// Low       = Fair         50–100      60–120      15–30       25–50       (Yellow)
// Medium    = Moderate     100–200     120–180     30–55       50–90       (Orange)
// High      = Poor         200–400     180–240     55–110      90–180      (Red)
// Very high = Very Poor    >400        >240        >110        >180        (Purple)
//
enum CAQIEuropeScale: Int, CustomStringConvertible, CaseIterable {
    case good = 1, fair = 2, moderate = 3, poor = 4, veryPoor = 5, indefinite = 0
    
    init(for element: ChemicalElements) {
        switch element {
        case let .no2(value):
            switch value {
            case 0   ..< 50:              self = .good
            case 50  ..< 100:             self = .fair
            case 100 ..< 200:             self = .moderate
            case 200 ..< 400:             self = .poor
            case 400 ..< Double.infinity: self = .veryPoor
            default:                      self = .indefinite
            }
        case let .o3(value):
            switch value {
            case 0   ..< 60:              self = .good
            case 60  ..< 120:             self = .fair
            case 120 ..< 180:             self = .moderate
            case 180 ..< 240:             self = .poor
            case 240 ..< Double.infinity: self = .veryPoor
            default:                      self = .indefinite
            }
        case let .pm2_5(value):
            switch value {
            case 0  ..< 15:               self = .good
            case 15 ..< 30:               self = .fair
            case 30 ..< 55:               self = .moderate
            case 55 ..< 110:              self = .poor
            case 110 ..< Double.infinity: self = .veryPoor
            default:                      self = .indefinite
            }
        case let .pm10(value):
            switch value {
            case 0  ..< 25:               self = .good
            case 25 ..< 50:               self = .fair
            case 50 ..< 90:               self = .moderate
            case 90 ..< 180:              self = .poor
            case 180 ..< Double.infinity: self = .veryPoor
            default:                      self = .indefinite
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
    
    var color: UIColor {
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


// MARK: - India Air Quality Index (AQI)
//
//                 (Range)     PM10      PM2.5     NO2       O3        CO        SO2        NH3         Pb        (Color)
//  Good           (0–50)      0–50      0–30      0–40      0–50      0–1.0     0–40       0–200       0–0.5     (Deep Green)
//  Satisfactory   (51–100)    51–100    31–60     41–80     51–100    1.1–2.0   41–80      201–400     0.5–1.0   (Light Green)
//  Moderate       (101–200)   101–250   61–90     81–180    101–168   2.1–10    81–380     401–800     1.1–2.0   (Yellow)
//  Poor           (201–300)   251–350   91–120    181–280   169–208   10–17     381–800    801–1200    2.1–3.0   (Orange)
//  Very Poor      (301–400)   351–430   121–250   281–400   209–748   17–34     801–1600   1200–1800   3.1–3.5   (Red)
//  Severe         (401-500)   430+      250+      400+      748+      34+       1600+      1800+       3.5+      (Maroon)
//
enum AQIIndiaScale: Int, CustomStringConvertible, CaseIterable {
    case good = 1, satisfactory = 2, moderate = 3, poor = 4, veryPoor = 5, severe = 6, indefinite = 0
    
    init(aqi: Int) {
        switch aqi {
        case 0...50:    self = .good
        case 51...100:  self = .satisfactory
        case 101...200: self = .moderate
        case 201...300: self = .poor
        case 301...400: self = .veryPoor
        case 401...500: self = .severe
        default:        self = .indefinite
        }
    }
    
    init(for element: ChemicalElements) {
        switch element {
        case let .pm10(value):
            switch value {
            case 0   ..< 50:              self = .good
            case 50  ..< 100:             self = .satisfactory
            case 100 ..< 250:             self = .moderate
            case 250 ..< 350:             self = .poor
            case 350 ..< 430:             self = .veryPoor
            case 430 ..< Double.infinity: self = .severe
            default:                      self = .indefinite
            }
        case let .pm2_5(value):
            switch value {
            case 0   ..< 30:              self = .good
            case 30  ..< 60:              self = .satisfactory
            case 60  ..< 90:              self = .moderate
            case 90  ..< 120:             self = .poor
            case 120 ..< 250:             self = .veryPoor
            case 250 ..< Double.infinity: self = .severe
            default:                      self = .indefinite
            }
        case let .no2(value):
            switch value {
            case 0   ..< 40:              self = .good
            case 40  ..< 80:              self = .satisfactory
            case 80  ..< 180:             self = .moderate
            case 180 ..< 280:             self = .poor
            case 280 ..< 400:             self = .veryPoor
            case 400 ..< Double.infinity: self = .severe
            default:                      self = .indefinite
            }
        case let .o3(value):
            switch value {
            case 0   ..< 50:              self = .good
            case 50  ..< 100:             self = .satisfactory
            case 100 ..< 168:             self = .moderate
            case 168 ..< 208:             self = .poor
            case 208 ..< 748:             self = .veryPoor
            case 748 ..< Double.infinity: self = .severe
            default:                      self = .indefinite
            }
        case let .co(value):
            switch value {
            case 0  ..< 1:                self = .good
            case 1  ..< 2:                self = .satisfactory
            case 2  ..< 10:               self = .moderate
            case 10 ..< 17:               self = .poor
            case 17 ..< 34:               self = .veryPoor
            case 34 ..< Double.infinity: self = .severe
            default:                      self = .indefinite
            }
        case let .so2(value):
            switch value {
            case 0  ..< 40:               self = .good
            case 40  ..< 80:              self = .satisfactory
            case 80  ..< 380:             self = .moderate
            case 380 ..< 800:             self = .poor
            case 800 ..< 1600:            self = .veryPoor
            case 1600 ..< Double.infinity: self = .severe
            default:                      self = .indefinite
            }
        case let .nh3(value):
            switch value {
            case 0    ..< 200:            self = .good
            case 200  ..< 400:            self = .satisfactory
            case 400  ..< 800:            self = .moderate
            case 800  ..< 1200:           self = .poor
            case 1200 ..< 1800:           self = .veryPoor
            case 1800 ..< Double.infinity: self = .severe
            default:                      self = .indefinite
            }
        default: self = .indefinite
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
    
    var color: UIColor {
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
}
