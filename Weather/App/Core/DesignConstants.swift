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
    
    
    
    // MARK: - SUPPORT STRUCT
    //
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
            medium = newyork.withSize(23)
            large = newyork.withSize(37)
        }
    }
}
