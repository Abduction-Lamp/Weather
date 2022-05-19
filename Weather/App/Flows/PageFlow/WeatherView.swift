//
//  WeatherView.swift
//  Weather
//
//  Created by Владимир on 13.04.2022.
//

import UIKit

final class WeatherView: UIView {

    private(set) var table: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .clear
        table.contentMode = .scaleToFill
        table.separatorStyle = .none
        table.isEditing = false
        table.allowsSelection = false
        table.showsVerticalScrollIndicator = false
        
        
        table.register(WeatherCityHeader.self, forHeaderFooterViewReuseIdentifier: WeatherCityHeader.reuseIdentifier)
        table.register(WeatherHourlyCell.self, forCellReuseIdentifier: WeatherHourlyCell.reuseIdentifier)
//        table.register(SearchCityCell.self, forCellReuseIdentifier: SearchCityCell.reuseIdentifier)
//        table.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.reuseIdentifier)
    
        return table
    }()
    
    
    // MARK: - Initiation
    //
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("📛\tWeatherView init(coder:) has not been implemented")
    }

    
    // MARK: - Configure Content
    //
    private func configureUI() {
        backgroundColor = .gray
        
        addSubview(table)

        
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            table.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            table.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            table.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
