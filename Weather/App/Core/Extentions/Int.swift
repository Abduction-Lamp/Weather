//
//  Int.swift
//  Weather
//
//  Created by Владимир on 25.05.2022.
//

import UIKit

extension Int {
    
    func degreesToRadians() -> CGFloat {
        return CGFloat(Double.init(self) * Double.pi / 180.0)
    }

    func radiansToDegrees() -> CGFloat {
        return CGFloat(Double.init(self) / Double.pi * 180.0)
    }
}
