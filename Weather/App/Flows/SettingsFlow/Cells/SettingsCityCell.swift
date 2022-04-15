//
//  SettingsCityCell.swift
//  Weather
//
//  Created by Владимир on 15.04.2022.
//

import UIKit

final class SettingsCityCell: UITableViewCell {
    static let reuseIdentifier = "SettingsCityCell"

    private lazy var city: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: UIFont.labelFontSize)
        return label
    }()

    private lazy var icon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .black
        return imageView
    }()

    private lazy var temperature: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: UIFont.labelFontSize)
        return label
    }()

    
    weak var viewModel: SettingsCityCellViewModelProtocol? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            city.text = viewModel.data.city
            icon.image = UIImage(systemName: "cloud.moon.rain")
            temperature.text = viewModel.data.temperature
        }
    }

    
    // MARK: - Initiation
    //
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureContent()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        city.text = nil
        icon.image = nil
        temperature.text = nil
    }
    
    
    // MARK: - Configure Content & Set Data
    //
    private func configureContent() {
        self.contentView.backgroundColor = .white
        self.contentView.addSubview(city)
        self.contentView.addSubview(icon)
        self.contentView.addSubview(temperature)

        icon.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -15.0).isActive = true
        icon.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 25.0).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 25.0).isActive = true

        temperature.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        temperature.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        temperature.rightAnchor.constraint(equalTo: icon.leftAnchor, constant: -15.0).isActive = true
        temperature.widthAnchor.constraint(equalToConstant: 50.0).isActive = true

        city.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        city.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        city.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15.0).isActive = true
        city.rightAnchor.constraint(equalTo: temperature.leftAnchor, constant: -5.0).isActive = true
    }
}
