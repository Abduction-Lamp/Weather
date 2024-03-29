//
//  LocationService.swift
//  Weather
//
//  Created by Владимир on 14.06.2022.
//

import Foundation
import CoreLocation

final class Location: NSObject, LocationServiceProtoco {

    private let manager: CLLocationManager?
    private lazy var observers = [LocationObserver]()
    
    override init() {
        manager = CLLocationManager()
        super.init()
        
        manager?.requestWhenInUseAuthorization()
        manager?.delegate = self
    }
    
    deinit {
        removeAll()
    }
        
    func subscribe(listener: LocationObserver) {
        observers.append(listener)
    }
    
    func remove(_ listener: LocationObserver) {
        if let index = observers.firstIndex(where: { $0.uuid == listener.uuid }) {
            observers.remove(at: index)
        }
    }
    
    func removeAll() {
        observers.removeAll()
    }
    
    func current() {
        manager?.requestLocation()
    }
    
    private func notify(location: Result<CityData, Error>) {
        let result: Result<CityData, Error>
        switch location {
        case .success(let city):
            result = .success(city)
        case .failure(let error):
            result = .failure(error)
        }
        observers.forEach { $0.refresh(location: result) }
    }
}


extension Location: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        CLGeocoder.init().reverseGeocodeLocation(location) { [weak self] (places, error) in
            if let error = error {
                print("⚠️ Location > Geocoder: " + error.localizedDescription)
                self?.notify(location: .failure(error))
            } else {
                guard let locality = places?.first?.locality else { return }
                let city = CityData(eng: locality, rus: locality, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                self?.notify(location: .success(city))
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        notify(location: .failure(error))
        print("⚠️ Location > Fail: " + error.localizedDescription)
    }
}
