//
//  CityCell.swift
//  Weather
//
//  Created by Владимир on 15.04.2022.
//

import UIKit

final class CityCell: UITableViewCell {
    static let reuseIdentifier = "CityCell"
    
    private let padding = DesignConstants.shared.padding
    
    private lazy var city: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .label
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
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("📛 CityCell init(coder:) has not been implemented")
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

    private func configureUI() {        
        contentView.addSubview(city)
        
        NSLayoutConstraint.activate([
            city.topAnchor.constraint(equalTo: contentView.topAnchor),
            city.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            city.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: padding.medium),
            city.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -padding.medium)
        ])
    }
}
