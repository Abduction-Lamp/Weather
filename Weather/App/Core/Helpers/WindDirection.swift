//
//  WindDirection.swift
//  Weather
//
//  Created by Владимир on 26.05.2022.
//

import Foundation

enum WindDirection: String {
    case north               = "С"
    case northNorthEast      = "ССВ"
    case northEast           = "СВ"
    case eastNorthEast       = "ВСВ"
    case east                = "В"
    case eastSouthEast       = "ВЮВ"
    case southEast           = "ЮВ"
    case southSouthEast      = "ЮЮВ"
    case south               = "Ю"
    case southSouthWestern   = "ЮЮЗ"
    case southWestern        = "ЮЗ"
    case westernWesternSouth = "ЗЗЮ"
    case western             = "З"
    case westernNorthWestern = "ЗСЗ"
    case northWestern        = "СЗ"
    case northNorthWestern   = "ССЗ"
    case unknown             = ""

    init(_ deg: Int?) {
        guard let direction = deg else {
            self = .unknown
            return
        }
        switch direction {
        case 0...11   : self = .north
        case 12...33  : self = .northNorthEast
        case 34...56  : self = .northEast
        case 57...78  : self = .eastNorthEast
        case 79...101 : self = .east
        case 102...123: self = .eastSouthEast
        case 124...146: self = .southEast
        case 147...168: self = .southSouthEast
        case 169...191: self = .south
        case 192...213: self = .southSouthWestern
        case 214...236: self = .southWestern
        case 237...258: self = .westernWesternSouth
        case 259...281: self = .western
        case 282...303: self = .westernNorthWestern
        case 304...326: self = .northWestern
        case 327...348: self = .northNorthWestern
        case 349...360: self = .north
        default:
            self = .unknown
        }
    }
}
