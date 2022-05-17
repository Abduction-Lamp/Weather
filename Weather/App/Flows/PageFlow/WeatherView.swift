//
//  WeatherView.swift
//  Weather
//
//  Created by Владимир on 13.04.2022.
//

import UIKit

final class WeatherView: UIView {

    private(set) var city: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: UIFont.labelFontSize)
        label.numberOfLines = 17
        return label
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
        backgroundColor = .white
        addSubview(city)

        city.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        city.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor).isActive = true
    }
}
