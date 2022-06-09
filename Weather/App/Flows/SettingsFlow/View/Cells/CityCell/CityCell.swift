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
    
    
    var viewModel: CityCellViewModelProtocol? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            city.text = viewModel.data.city
        }
    }
    
    
    // MARK: Initialization
    //
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureContent()
    }

    required init?(coder: NSCoder) {
        fatalError("📛\tCityCell init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        city.text = nil
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
        
        NSLayoutConstraint.activate([
            city.topAnchor.constraint(equalTo: contentView.topAnchor),
            city.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            city.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: const.padding.medium.left),
            city.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -const.padding.medium.right)
        ])
    }
}
