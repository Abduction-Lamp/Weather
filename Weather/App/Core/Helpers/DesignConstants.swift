//
//  DesignConstants.swift
//  Weather
//
//  Created by Владимир on 18.05.2022.
//

import UIKit

final class DesignConstants {
    typealias Padding = (small: CGFloat, medium: CGFloat, large: CGFloat)
    
    static let shared = DesignConstants()
    private init() { }

    let padding: Padding = (small: 5, medium: 16, large: 27)
    let font = Fonts()
    let size = Sizes()
    let gradient = GradientLayer()
}


// MARK: - Support Fonts struct
//
extension DesignConstants {
    
    struct Fonts {
        typealias LineHeight = (tiny: CGFloat, small: CGFloat, medium: CGFloat, large: CGFloat, huge: CGFloat)
        
        let tiny:   UIFont
        let small:  UIFont
        let medium: UIFont
        let large:  UIFont
        let huge:   UIFont
        
        let height: LineHeight
        
        init() {
            let newyork = UIFont(name: "NewYork-Regular", size: UIFont.labelFontSize) ?? UIFont.systemFont(ofSize: UIFont.labelFontSize)
            
            tiny   = newyork.withSize(15)
            small  = newyork.withSize(17)
            medium = newyork.withSize(25)
            large  = newyork.withSize(41)
            huge   = newyork.withSize(57)
            
            height = (tiny: tiny.lineHeight.rounded(.up),
                      small: small.lineHeight.rounded(.up),
                      medium: medium.lineHeight.rounded(.up),
                      large: large.lineHeight.rounded(.up),
                      huge: huge.lineHeight.rounded(.up))
        }
    }
}


// MARK: - Support Sizes struct
//
extension DesignConstants {
    
    struct Sizes {
        let icon = CGSize(width: 50, height: 25)
        
        var screen: CGSize {
            return CGSize(width:  min(UIScreen.main.bounds.width, UIScreen.main.bounds.height),
                          height: max(UIScreen.main.bounds.width, UIScreen.main.bounds.height))
        }
    }
}


// MARK: - Support Gradient struct
//
extension DesignConstants {
    
    struct GradientLayer {
        typealias Gradient = [CGColor]
        
        let indefinite: Gradient = [UIColor.systemGray.cgColor, UIColor.black.cgColor]
        let morning:    Gradient = [UIColor.systemMint.cgColor, UIColor.systemPurple.cgColor]
        let afternoon:  Gradient = [UIColor.systemYellow.cgColor, UIColor.systemBlue.cgColor]
        let evening:    Gradient = [UIColor.systemBlue.cgColor, UIColor.systemPink.cgColor]
        let night:      Gradient = [UIColor.init(red: 132, green: 94, blue: 152).cgColor, UIColor.init(red: 46, green: 48, blue: 96).cgColor]
        
        func fetch(status: TimeOfDay?) -> Gradient {
            switch status {
            case .morning:   return morning
            case .afternoon: return afternoon
            case .evening:   return evening
            case .night:     return night
            default:         return indefinite
            }
        }
        
        func fetch(time: TimeInterval? = nil, sunrise: TimeInterval? = nil, sunset: TimeInterval? = nil) -> Gradient {
            guard let time = time, let sunrise = sunrise, let sunset = sunset else { return indefinite }
            return fetch(status: TimeOfDay.init(time: time, sunrise: sunrise, sunset: sunset))
        }
    }
}
