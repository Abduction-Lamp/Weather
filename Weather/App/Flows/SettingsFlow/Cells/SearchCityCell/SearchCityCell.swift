//
//  SearchCityCell.swift
//  Weather
//
//  Created by Владимир on 26.04.2022.
//

import UIKit

final class SearchCityCell: UITableViewCell {
    static let reuseIdentifier = "SearchCityCell"

    private lazy var city: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: UIFont.labelFontSize)
        return label
    }()

    
    weak var viewModel: SearchCityCellViewModelProtocol? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            city.text = viewModel.data.city
        }
    }

    
    // MARK: - Initiation
    //
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureContent()
    }

    required init?(coder: NSCoder) {
        fatalError("📛\tSearchCityCell init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        city.text = nil
    }
    
    
    // MARK: - Configure Content & Set Data
    //
    private func configureContent() {
        contentView.backgroundColor = .white
        contentView.addSubview(city)

        city.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        city.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        city.leftAnchor.constraint(equalTo: leftAnchor, constant: 15.0).isActive = true
        city.rightAnchor.constraint(equalTo: rightAnchor, constant: -5.0).isActive = true
    }
}
