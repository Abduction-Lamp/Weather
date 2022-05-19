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
        
        weatherView.table.delegate = self
        weatherView.table.dataSource = self
        
        viewModel?.weather.bind { weather in
            guard let _ = weather else { return }
            DispatchQueue.main.async {
                self.weatherView.table.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel?.feach()
    }
}


extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        section == 0 ? WeatherCityHeader.height : 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            guard
                let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: WeatherCityHeader.reuseIdentifier) as? WeatherCityHeader,
                let model = viewModel?.makeWeatherCityHeaderModel()
            else { return nil }

            header.setup(model: model)
            return header
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherHourlyCell.reuseIdentifier) as? WeatherHourlyCell else {
            return UITableViewCell()
        }
        if let model = viewModel?.makeWeatherHourlyModel(){
            cell.setup(model: model)
        }
        return cell
    }
}
