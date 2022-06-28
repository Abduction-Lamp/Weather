//
//  LocationWeatherViewModel.swift
//  Weather
//
//  Created by Владимир on 27.06.2022.
//

import Foundation


final class LocationWeatherViewModel: WeatherViewModel {
    
    let uuid: String = UUID().uuidString
    private weak var location: LocationServiceProtoco?
    
    init(city: CityData?, network: NetworkServiceProtocol, settings: Settings?, location: LocationServiceProtoco?) {
        super.init(city: city, network: network, settings: settings)
        
        self.location = location
        self.location?.subscribe(listener: self)
        self.location?.current()
    }
    
    deinit {
        location?.remove(self)
    }
    
    @objc
    public override func feach() {
        location?.current()
    }
}


extension LocationWeatherViewModel: LocationObserver {
    
    func refresh(location: Result<CityData, Error>) {
        switch location {
        case .success(let city):
            self.city = city
            super.feach()
        case .failure(let error):
            print(error)
        }
    }
}
