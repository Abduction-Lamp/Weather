//
//  DesignConstants.swift
//  Weather
//
//  Created by Владимир on 18.05.2022.
//

import UIKit

final class DesignConstants {
    
    static let shared = DesignConstants()
    private init() { }

    let padding = Padding()
    let font = Fonts()
    let size = Sizes()
    let gradient = GradientLayer()
    
    
    // MARK: Support structs
    ///
    struct Padding {
        let small = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        let medium = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        let large = UIEdgeInsets(top: 27, left: 27, bottom: 27, right: 27)
    }
    
    struct Fonts {
        let tiny: UIFont
        let small: UIFont
        let medium: UIFont
        let large: UIFont
        
        init() {
            let newyork = UIFont(name: "NewYork-Regular", size: UIFont.labelFontSize) ?? UIFont.systemFont(ofSize: UIFont.labelFontSize)
            tiny = newyork.withSize(15)
            small = newyork.withSize(17)
            medium = newyork.withSize(25)
            large = newyork.withSize(41)
        }
    }
    
    struct Sizes {
        let icon = CGSize(width: 25, height: 25)
    }
    
    struct GradientLayer {
        typealias Gradient = [CGColor]
        
        let indefinite: Gradient = [UIColor.systemGray.cgColor, UIColor.black.cgColor]
        let morning:    Gradient = [UIColor.systemGreen.cgColor, UIColor.systemBlue.cgColor]
        let afternoon:  Gradient = [UIColor.systemYellow.cgColor, UIColor.systemBlue.cgColor]
        let evening:    Gradient = [UIColor.systemBlue.cgColor, UIColor.systemRed.cgColor]
        let night:      Gradient = [
            UIColor.init(red: 132, green: 94, blue: 152).cgColor,
            UIColor.init(red: 46, green: 48, blue: 96).cgColor
        ]
        
        func fetch(time: TimeInterval? = nil, sunrise: TimeInterval? = nil, sunset: TimeInterval? = nil) -> Gradient {
            guard let time = time, let sunrise = sunrise, let sunset = sunset else { return indefinite }
            switch TimeOfDay.init(time: time, sunrise: sunrise, sunset: sunset) {
            case .morning:
                return morning
            case .afternoon:
                return afternoon
            case .evening:
                return evening
            case .night:
                return night
            }
        }
    }
}
