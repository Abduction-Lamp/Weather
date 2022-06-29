//
//  LocationProtocols.swift
//  Weather
//
//  Created by Владимир on 29.06.2022.
//

import Foundation

protocol LocationObserver: AnyObject {
    var uuid: String { get }
    
    func refresh(location: Result<CityData, Error>)
}

protocol LocationServiceProtoco: AnyObject {
    var state: LocationState { get }
    
    func subscribe(listener: LocationObserver)
    func remove(_ listener: LocationObserver)
    func removeAll()
    
    func current()
}

enum  LocationState {
    case locating
    case success(CityData)
    case failure(Error)
}
