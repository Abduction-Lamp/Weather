//
//  GradientLayerService.swift
//  Weather
//
//  Created by Владимир on 23.05.2022.
//

import UIKit

protocol GradientLayerServiceProtocol {
    typealias Gradient = [CGColor]
    
    func fetch(time: TimeInterval?, sunrise: TimeInterval?, sunset: TimeInterval?) -> Gradient
}

final class GradientLayerService: GradientLayerServiceProtocol {

    let indefinite: Gradient = [UIColor.systemGray.cgColor, UIColor.black.cgColor]
    let morning:    Gradient = [UIColor.systemYellow.cgColor, UIColor.systemRed.cgColor]
    let afternoon:  Gradient = [UIColor.systemBlue.cgColor, UIColor.systemRed.cgColor]
    let evening:    Gradient = [UIColor.systemYellow.cgColor, UIColor.systemRed.cgColor]
    let night:      Gradient = [UIColor.systemIndigo.cgColor, UIColor.systemPurple.cgColor]
    
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
