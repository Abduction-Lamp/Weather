//
//  WeatherViewController.swift
//  Weather
//
//  Created by Владимир on 13.04.2022.
//

import UIKit

final class WeatherViewController: UIViewController {
    
    public var weatherView: WeatherView {
        guard let view = self.view as? WeatherView else {
            return WeatherView(frame: self.view.frame)
        }
        return view
    }
    
    var viewModel: WeatherViewModelProtocol?
    
    
    // MARK: Initialization
    //
    init(viewModel: WeatherViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("📛\tWeatherViewController init(coder:) has not been implemented")
    }
    
    
    // MARK: Lifecycle
    //
    override func loadView() {
        super.loadView()
        
        view = WeatherView(frame: view.frame)
        
        weatherView.table.delegate = self
        weatherView.table.dataSource = self
        
        weatherView.refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        
        viewModel?.weather.bind { weather in
            DispatchQueue.main.async {
                self.weatherView.refreshControl.endRefreshing()
                guard let _ = weather else { return }
                self.weatherView.table.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel?.feach()
    }
}


// MARK: - UITableViewDelegate, UITableViewDataSource
//
extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return WeatherHourlyCell.height
        case 1:
            return WeatherDailyCell.height
        case 2:
            return WeatherWindCell.height
        case 3:
            return WeatherPressureAndHumidityCell.height
        default:
            return 44
        }
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
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherHourlyCell.reuseIdentifier) as? WeatherHourlyCell else {
                return UITableViewCell()
            }
            if let model = viewModel?.makeWeatherHourlyModel() {
                cell.setup(model: model)
            }
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherDailyCell.reuseIdentifier) as? WeatherDailyCell else {
                return UITableViewCell()
            }
            if let model = viewModel?.makeWeatherDailyModel() {
                cell.setup(model: model)
            }
            return cell
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherWindCell.reuseIdentifier) as? WeatherWindCell else {
                return UITableViewCell()
            }
            if let model = viewModel?.makeWeatherWindModel() {
                cell.setup(model: model)
            }
            return cell
            
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherPressureAndHumidityCell.reuseIdentifier) as? WeatherPressureAndHumidityCell else {
                return UITableViewCell()
            }
            if let model = viewModel?.makeWeatherPressureAndHumidityModel() {
                cell.setup(model: model)
            }
            return cell
            
        default:
            return UITableViewCell()
        }
    }
}


// MARK: - Actions
//
extension WeatherViewController {
    
    @objc func refresh(_ sender: AnyObject) {
        weatherView.refreshControl.beginRefreshing()
        viewModel?.feach()
    }
}
