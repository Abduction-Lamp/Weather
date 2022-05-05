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
    
    private var viewModel: WeatherViewModelProtocol?
    
    
    
    // MARK: - Initiation
    //
    init(viewModel: WeatherViewModelProtocol) {
        self.viewModel = viewModel
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
        weatherView.city.text = viewModel?.city.rus
        
        viewModel?.weather.bind { weather in
            guard let weather = weather else { return }
            if let temp = weather.current?.temp,
               let city = self.viewModel?.city.rus {
                DispatchQueue.main.async {
                    self.weatherView.city.text = "\(city) \(temp)"
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        viewModel?.feach()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
}
