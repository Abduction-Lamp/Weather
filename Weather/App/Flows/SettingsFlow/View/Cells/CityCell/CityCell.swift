//
//  CityCell.swift
//  Weather
//
//  Created by Владимир on 15.04.2022.
//

import UIKit

final class CityCell: UITableViewCell {
    static let reuseIdentifier = "CityCell"
    
    private let const = DesignConstants.shared
    
    private lazy var city: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .black
        label.font = .systemFont(ofSize: UIFont.labelFontSize)
        return label
    }()
    
    private lazy var icon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.tintColor = .black
        return imageView
    }()
    
    private lazy var temperature: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.textColor = .black
        label.font = .systemFont(ofSize: UIFont.labelFontSize)
        return label
    }()
    
    
    var viewModel: CityCellViewModelProtocol? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            city.text = viewModel.data.city
            icon.image = UIImage(systemName: "cloud.moon.rain")
            temperature.text = viewModel.data.temperature
        }
    }
    
    
    // MARK: Initialization
    ///
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureContent()
    }

    required init?(coder: NSCoder) {
        fatalError("📛\tCityCell init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        city.text = nil
        icon.image = nil
        temperature.text = nil
        viewModel = nil
        super.prepareForReuse()
    }
}


// MARK: - Support methods
//
extension CityCell {

    // MARK: Configure content
    ///
    private func configureContent() {
        contentView.backgroundColor = .white
        
        contentView.addSubview(city)
        contentView.addSubview(icon)
        contentView.addSubview(temperature)
        
        NSLayoutConstraint.activate([
            icon.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -const.padding.medium.right),
            icon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            icon.widthAnchor.constraint(equalToConstant: 25.0),
            icon.heightAnchor.constraint(equalToConstant: 25.0),

            temperature.topAnchor.constraint(equalTo: contentView.topAnchor),
            temperature.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            temperature.rightAnchor.constraint(equalTo: icon.leftAnchor, constant: -const.padding.medium.right),
            temperature.widthAnchor.constraint(equalToConstant: 50.0),

            city.topAnchor.constraint(equalTo: contentView.topAnchor),
            city.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            city.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: const.padding.medium.left),
            city.rightAnchor.constraint(equalTo: temperature.leftAnchor, constant: -const.padding.small.right)
        ])
    }
}
