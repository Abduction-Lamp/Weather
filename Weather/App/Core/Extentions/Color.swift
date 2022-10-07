//
//  Color.swift
//  Weather
//
//  Created by Владимир on 24.05.2022.
//

import UIKit

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        assert(0...255 ~= red, "⚠️ Invalid red component")
        assert(0...255 ~= green, "⚠️ Invalid green component")
        assert(0...255 ~= blue, "⚠️ Invalid blue component")
        assert(0.0...1.0 ~= alpha, "⚠️ Invalid alpha component")
        
        self.init(red:   CGFloat(red)/255.0,
                  green: CGFloat(green)/255.0,
                  blue:  CGFloat(blue)/255.0,
                  alpha: alpha)
    }
}
