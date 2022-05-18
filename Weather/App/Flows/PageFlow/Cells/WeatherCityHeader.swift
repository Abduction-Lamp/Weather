//
//  WeatherCityHeader.swift
//  Weather
//
//  Created by Владимир on 17.05.2022.
//

import UIKit

final class WeatherCityHeader: UITableViewHeaderFooterView {
    static let reuseIdentifier = "WeatherCityHeader"
    
    private let const = DesignConstants.shared
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .black
        label.font = const.font.newyork
        return label
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .black
        label.font = const.font.newyork
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .black
        label.font = const.font.newyork
        return label
    }()
    
    
    
    // MARK: - Initiation
    //
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        configureContent()
    }

    required init?(coder: NSCoder) {
        fatalError("📛\tCityCell init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        cityLabel.text = nil
        temperatureLabel.text = nil
        descriptionLabel.text = nil
        super.prepareForReuse()
    }
    
    
    private func configureContent() {
        contentView.backgroundColor = .clear
        
        contentView.addSubview(cityLabel)
        contentView.addSubview(temperatureLabel)
        contentView.addSubview(descriptionLabel)
        
        
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: const.padding.medium.top),
            cityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: const.padding.small.left),
            cityLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -const.padding.small.right),
            cityLabel.heightAnchor.constraint(equalToConstant: 35),
            
            temperatureLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: const.padding.small.top),
            temperatureLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: const.padding.small.left),
            temperatureLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -const.padding.small.right),
            temperatureLabel.heightAnchor.constraint(equalToConstant: 45),
            
            descriptionLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: const.padding.small.top),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: const.padding.small.left),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -const.padding.small.right),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
    }

    public func setup(model: OneCallResponse) {
        cityLabel.text = "Москва"
        temperatureLabel.text = model.current?.temp.description ?? ""
        descriptionLabel.text = model.current?.weather.first?.description ?? ""
    }
}
