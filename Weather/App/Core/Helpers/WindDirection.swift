//
//  WindDirection.swift
//  Weather
//
//  Created by Владимир on 26.05.2022.
//

import Foundation

enum WindDirection {
    case north
    case northNorthEast
    case northEast
    case eastNorthEast
    case east
    case eastSouthEast
    case southEast
    case southSouthEast
    case south
    case southSouthWestern
    case southWestern
    case westernWesternSouth
    case western
    case westernNorthWestern
    case northWestern
    case northNorthWestern
    case unknown

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
        default:        self = .unknown
        }
    }
}

extension WindDirection: CustomStringConvertible {
    
    var description: String {
        switch self {
        case .north:                return NSLocalizedString("WindDirection.North"              , comment: "North")
        case .northNorthEast:       return NSLocalizedString("WindDirection.NorthNorthEast"     , comment: "North North East")
        case .northEast:            return NSLocalizedString("WindDirection.NorthEast"          , comment: "North East")
        case .eastNorthEast:        return NSLocalizedString("WindDirection.EastNorthEast"      , comment: "East North East")
        case .east:                 return NSLocalizedString("WindDirection.East"               , comment: "East")
        case .eastSouthEast:        return NSLocalizedString("WindDirection.EastSouthEast"      , comment: "East South East")
        case .southEast:            return NSLocalizedString("WindDirection.SouthEast"          , comment: "South East")
        case .southSouthEast:       return NSLocalizedString("WindDirection.SouthSouthEast"     , comment: "South South East")
        case .south:                return NSLocalizedString("WindDirection.South"              , comment: "South")
        case .southSouthWestern:    return NSLocalizedString("WindDirection.SouthSouthWestern"  , comment: "South South Western")
        case .southWestern:         return NSLocalizedString("WindDirection.SouthWestern"       , comment: "South Western")
        case .westernWesternSouth:  return NSLocalizedString("WindDirection.WesternWesternSouth", comment: "Western Western South")
        case .western:              return NSLocalizedString("WindDirection.Western"            , comment: "Western")
        case .westernNorthWestern:  return NSLocalizedString("WindDirection.WesternNorthWestern", comment: "Western North Western")
        case .northWestern:         return NSLocalizedString("WindDirection.NorthWestern"       , comment: "North Western")
        case .northNorthWestern:    return NSLocalizedString("WindDirection.NorthNorthWestern"  , comment: "North North Western")
        default:                    return ""
        }
    }
}
