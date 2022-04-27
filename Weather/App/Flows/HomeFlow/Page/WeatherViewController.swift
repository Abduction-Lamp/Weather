//
//  WeatherViewController.swift
//  Weather
//
//  Created by Владимир on 13.04.2022.
//

import UIKit

final class WeatherViewController: UIViewController {
    
    private var weatherView: WeatherView {
        guard let view = self.view as? WeatherView else {
            return WeatherView(frame: self.view.frame)
        }
        return view
    }
    
    public var city: String

    
    
    // MARK: - Initiation
    //
    init(city: String) {
        self.city = city
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("📛\tWeatherViewController init(coder:) has not been implemented")
    }

    
    // MARK: - Lifecycle
    //
    override func loadView() {
        super.loadView()
        
        view = WeatherView(frame: view.frame)
        weatherView.city.text = city
    }
}
