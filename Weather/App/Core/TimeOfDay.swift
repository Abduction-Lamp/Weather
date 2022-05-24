//
//  TimeOfDay.swift
//  Weather
//
//  Created by Владимир on 23.05.2022.
//

import Foundation

enum TimeOfDay {
    case morning, afternoon, evening, night
    
    init(time: TimeInterval, sunrise: TimeInterval, sunset: TimeInterval) {
        let oneHour: TimeInterval = 3600
        let twoHours: TimeInterval = 7200
        
        switch time {
        case (sunrise - oneHour) ... (sunrise + twoHours):
            self = .morning
        case (sunrise + twoHours + 1) ... (sunset - oneHour - 1):
            self = .afternoon
        case (sunset - oneHour) ... (sunset + twoHours):
            self = .evening
        default:
            self = .night
        }
    }
}
