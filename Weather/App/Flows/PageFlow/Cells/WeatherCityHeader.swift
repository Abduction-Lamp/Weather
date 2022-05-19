//
//  WeatherCityHeader.swift
//  Weather
//
//  Created by Владимир on 17.05.2022.
//

import UIKit

final class WeatherCityHeader: UITableViewHeaderFooterView {
    static let reuseIdentifier = "WeatherCityHeader"
    static var height: CGFloat {
        let const = DesignConstants.shared
        let large = 3 * const.padding.large.top
        let small = 3 * const.padding.small.top
        let result = large + small + const.font.medium.lineHeight + const.font.large.lineHeight + const.font.small.lineHeight
        return result.rounded(.up)
    }
    
    private let const = DesignConstants.shared
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .black
        label.font = const.font.medium
        return label
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .black
        label.font = const.font.large
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .black
        label.font = const.font.small
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
            cityLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: const.padding.large.top),
            cityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: const.padding.small.left),
            cityLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -const.padding.small.right),
            cityLabel.heightAnchor.constraint(equalToConstant: const.font.medium.lineHeight),
            
            temperatureLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: const.padding.small.top),
            temperatureLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: const.padding.small.left),
            temperatureLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -const.padding.small.right),
            temperatureLabel.heightAnchor.constraint(equalToConstant: const.font.large.lineHeight),
            
            descriptionLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: const.padding.small.top),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: const.padding.small.left),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -const.padding.small.right),
            descriptionLabel.heightAnchor.constraint(equalToConstant: const.font.small.lineHeight)
        ])
    }

    public func setup(model: WeatherCityHeaderModel) {
        cityLabel.text = model.city
        temperatureLabel.text = model.temperature
        descriptionLabel.text = model.description
    }
}
