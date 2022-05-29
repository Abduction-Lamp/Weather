//
//  IconService.swift
//  Weather
//
//  Created by Владимир on 21.05.2022.
//

import UIKit

protocol IconServiceProtocol {
    func fetch(conditions id: Int?, time: TimeInterval?, sunrise: TimeInterval?, sunset: TimeInterval?) -> UIImage?
}


final class IconService: IconServiceProtocol {
    
    enum ExpandedIconSet: Int {
        case sunrise = 1000
        case sunset = 1001
    }
    
    func fetch(conditions id: Int?, time: TimeInterval? = nil, sunrise: TimeInterval? = nil, sunset: TimeInterval? = nil) -> UIImage? {
        
        var isNight: Bool = false
        if let time = time, let sunrise = sunrise, let sunset = sunset {
            let day24hours: TimeInterval = 24 * 3600
            switch time {
            case sunrise ... sunset, (sunrise + day24hours) ... (sunset + day24hours):
                isNight = false
            default:
                isNight = true
            }
        }

        var systemName: String
        var colorConfig: UIImage.SymbolConfiguration
        
        switch id {
        ///      cloud.bolt.rain.fill
        /// 200     гроза с небольшим дождем
        /// 201     гроза с дождем
        /// 202     гроза с сильным дождем
        /// 230     гроза с легкой моросью
        /// 231     гроза с моросью
        /// 232     гроза с сильной моросью
        ///
        case 200, 201, 202, 230, 231, 232:
            systemName = "cloud.bolt.rain.fill"
            colorConfig = UIImage.SymbolConfiguration(paletteColors: [.white, .systemBlue])
            
        ///      cloud.bolt.fill
        /// 210     слабая гроза
        /// 211     гроза
        /// 212     сильная гроза
        ///
        case 210, 211, 212:
            systemName = "cloud.bolt.fill"
            colorConfig = UIImage.SymbolConfiguration(paletteColors: [.white, .systemYellow])
            
        ///      cloud.sun.bolt.fill
        ///      cloud.moon.bolt.fill
        /// 221     разорванная гроза
        ///
        case 221:
            systemName = isNight ? "cloud.moon.bolt.fill" : "cloud.sun.bolt.fill"
            colorConfig = UIImage.SymbolConfiguration(paletteColors: [.white, .systemYellow])
            
        ///      cloud.drizzle.fill
        /// 300     морось легкой интенсивности
        /// 301     морось
        /// 302     интенсивный моросящий дождь
        /// 310     моросящий дождь легкой интенсивности
        /// 311     моросящий дождь
        ///
        case 300, 301, 302, 310, 311:
            systemName = "cloud.drizzle.fill"
            colorConfig = UIImage.SymbolConfiguration(paletteColors: [.white, .systemBlue])
        
        ///      cloud.rain.fill
        /// 312     интенсивный моросящий дождь
        /// 314     сильный дождь дождь и морось
        /// 321     дождь морось
        /// 501     умеренный дождь
        /// 502     дождь сильной интенсивности
        /// 503     очень сильный дождь
        /// 531     неровный дождь
        ///
        case 312, 314, 321, 501, 502, 503, 531:
            systemName = "cloud.rain.fill"
            colorConfig = UIImage.SymbolConfiguration(paletteColors: [.white, .systemBlue])
            
        ///      cloud.heavyrain.fill
        /// 313     ливень дождь и морось
        /// 504     экстремальный дождь
        /// 520     ливневый дождь небольшой интенсивности
        /// 521     ливневый дождь
        /// 522     ливневый дождь сильной интенсивности
        case 313, 504, 520, 521, 522:
            systemName = "cloud.heavyrain.fill"
            colorConfig = UIImage.SymbolConfiguration(paletteColors: [.white, .systemBlue])
            
        ///      cloud.sun.rain.fill
        ///      cloud.moon.rain.fill
        /// 500     небольшой дождь
        ///
        case 500:
            systemName = isNight ? "cloud.moon.rain.fill" : "cloud.sun.rain.fill"
            colorConfig = UIImage.SymbolConfiguration(paletteColors: [.white, .systemYellow, .systemBlue])
            
        ///      cloud.sleet.fill
        /// 511     ледяной дождь
        /// 612     Легкий ливень
        /// 613     Ливневый снег
        /// 615     Небольшой дождь и снег
        /// 616     Дождь и снег
        /// 620     Легкий дождь снег
        /// 621     Снег под душем
        /// 622     Сильный ливневый снег
        ///
        case 511, 612, 613, 615, 616, 620, 621, 622:
            systemName = "cloud.sleet.fill"
            colorConfig = UIImage.SymbolConfiguration(paletteColors: [.white, .systemBlue])
            
        ///      snowflake
        /// 600     Легкий снег
        ///
        case 600:
            systemName = "snowflake"
            colorConfig = UIImage.SymbolConfiguration(paletteColors: [.white])
            
        ///      cloud.snow.fill
        /// 601     Снег
        /// 602     Сильный снег
        /// 611     Снег
        ///
        case 601, 602, 611:
            systemName = "cloud.snow.fill"
            colorConfig = UIImage.SymbolConfiguration(paletteColors: [.systemGray6, .white])
            
        ///      cloud.fog.fill
        /// 741     Туман
        /// 762     Пепел
        ///
        case 741, 762:
            systemName = "cloud.fog.fill"
            colorConfig = UIImage.SymbolConfiguration(paletteColors: [.white, .white])
            
        ///      sun.haze.fill
        ///      cloud.fog.fill
        /// 701     Легкий туман
        /// 711     Дым
        /// 721     Дымка
        ///
        case 701, 711, 721:
            systemName = isNight ? "cloud.fog.fill" : "sun.haze.fill"
            colorConfig = UIImage.SymbolConfiguration(paletteColors: isNight ? [.white, .white] : [.white, .systemYellow])
            
        ///      sun.dust.fill
        ///      cloud.fog.fill
        /// 731     Пылевой песок
        /// 751     Песок
        /// 761     Пыль
        ///
        case 731, 751, 761:
            systemName = isNight ? "cloud.fog.fill" : "sun.dust.fill"
            colorConfig = UIImage.SymbolConfiguration(paletteColors: isNight ? [.white, .white] : [.white, .systemYellow])

        ///      hurricane
        /// 771     Шквал
        ///
        case 771:
            systemName = "hurricane"
            colorConfig = UIImage.SymbolConfiguration(paletteColors: [.white])
            
        ///      tornado
        /// 781     Торнадо
        ///
        case 781:
            systemName = "tornado"
            colorConfig = UIImage.SymbolConfiguration(paletteColors: [.white])
            
        ///      sun.max.fill
        ///      moon.stars.fill
        /// 800     Чистое ясное небо
        ///
        case 800:
            systemName = isNight ? "moon.stars.fill" : "sun.max.fill"
            colorConfig = UIImage.SymbolConfiguration(paletteColors: isNight ? [.white, .systemYellow] : [.systemYellow])
            
        ///      cloud.sun.fill
        ///      cloud.moon.fill
        /// 801     Облака несколько облаков: 11-25%
        ///
        case 801:
            systemName = isNight ? "cloud.moon.fill" : "cloud.sun.fill"
            colorConfig = UIImage.SymbolConfiguration(paletteColors: [.white, .systemYellow])
            
        ///      cloud.fill
        /// 802     Облака рассеянные облака: 25-50%
        ///
        case 802:
            systemName = "cloud.fill"
            colorConfig = UIImage.SymbolConfiguration(paletteColors: [.white])
            
        ///      smoke.fill
        /// 803     Облака разбитые облака: 51-84%
        /// 804     Облака облачность: 85-100%
        ///
        case 803, 804:
            systemName = "smoke.fill"
            colorConfig = UIImage.SymbolConfiguration(paletteColors: [.white])
            
        /// sunrise.fill
        ///
        case ExpandedIconSet.sunrise.rawValue:
            systemName = "sunrise.fill"
            colorConfig = UIImage.SymbolConfiguration(paletteColors: [.white, .systemYellow])
            
        /// sunset.fill
        ///
        case ExpandedIconSet.sunset.rawValue:
            systemName = "sunset.fill"
            colorConfig = UIImage.SymbolConfiguration(paletteColors: [.white, .systemYellow])
            
        default:
            systemName = "aqi.low"
            colorConfig = UIImage.SymbolConfiguration(paletteColors: [.white])
        }

        return UIImage.init(systemName: systemName, withConfiguration: colorConfig)
    }
}
