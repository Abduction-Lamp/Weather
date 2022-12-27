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
    
    private var mode: Mode = .none {
        didSet {
            switch self.mode {
            case .success(let isReloadData as Bool):
                self.weatherView.refreshControl.endRefreshing()
                if isReloadData {
                    self.weatherView.table.reloadData()
                }
            case .failure(let message as String):
                self.weatherView.refreshControl.endRefreshing()
                self.alert(title: "",
                           message: message,
                           actionTitle: NSLocalizedString("General.Alert.Cancel", comment: "Cancel"),
                           handler: nil)
            default: break
            }
        }
    }
    
    var viewModel: WeatherViewModelProtocol
    
    
    // MARK: Initialization
    init(viewModel: WeatherViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("📛 WeatherViewController init(coder:) has not been implemented")
    }
    
    
    // MARK: Lifecycle
    //
    override func loadView() {
        view = WeatherView()
        
        weatherView.table.delegate = self
        weatherView.table.dataSource = self
        
        weatherView.refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        
        viewModel.state.bind { [weak self] state in
            guard let self = self else { return }

            if Thread.isMainThread {
                self.mode = state
            } else {
                DispatchQueue.main.async {
                    self.mode = state
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        weatherView.refreshControl.beginRefreshing()
        viewModel.fetch()
    }
}


// MARK: - UITableViewDelegate, UITableViewDataSource
//
extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.getNumberOfSections()
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
        case 4:
            return calculationHeightOfAirPollutionCell()
        default:
            return 44
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        section == 0 ? WeatherCityHeader.height : 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: WeatherCityHeader.reuseIdentifier) as? WeatherCityHeader
            else { return nil }
            
            let model = viewModel.makeWeatherCityHeaderModel()
            header.setup(model: model)
            return header
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherHourlyCell.reuseIdentifier) as? WeatherHourlyCell
            else { return UITableViewCell() }
            let model = viewModel.makeWeatherHourlyModel()
            cell.setup(model: model)
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherDailyCell.reuseIdentifier) as? WeatherDailyCell
            else { return UITableViewCell() }
            let model = viewModel.makeWeatherDailyModel()
            cell.setup(model: model)
            return cell
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherWindCell.reuseIdentifier) as? WeatherWindCell
            else { return UITableViewCell() }
            let model = viewModel.makeWeatherWindModel()
            cell.setup(model: model)
            return cell
            
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherPressureAndHumidityCell.reuseIdentifier) as? WeatherPressureAndHumidityCell
            else { return UITableViewCell() }
            let model = viewModel.makeWeatherPressureAndHumidityModel()
            cell.setup(model: model)
            return cell
            
        case 4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherAirPollutionCell.reuseIdentifier) as? WeatherAirPollutionCell
            else { return UITableViewCell() }
            if let model = viewModel.makeWeatherAirPollutionModel() {
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
        viewModel.fetch()
    }
}


extension WeatherViewController {
    
    private func calculationHeightOfAirPollutionCell() -> CGFloat {
        let itemHeight = DesignConstants.shared.font.height.medium + DesignConstants.shared.padding.small
        let components = CGFloat(viewModel.getNumberOfAirComponents()) * itemHeight
        let result = (WeatherAirPollutionCell.height + components + DesignConstants.shared.padding.small).rounded(.up)
        return result
    }
}
