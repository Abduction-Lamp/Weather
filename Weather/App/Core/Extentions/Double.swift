//
//  Double+ToString.swift
//  Weather
//
//  Created by Владимир on 19.05.2022.
//

import Foundation

extension Double {
    
    public func toStringWithDegreeSymbol() -> String {
        let x = Int.init(self.rounded(.toNearestOrAwayFromZero))
        if x > 0 {
            return "+\(x)\u{00B0}"
        }
        return "\(x)\u{00B0}"
    }
}
