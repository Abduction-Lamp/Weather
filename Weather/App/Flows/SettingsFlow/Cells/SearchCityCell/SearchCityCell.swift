//
//  SearchCityCell.swift
//  Weather
//
//  Created by Владимир on 26.04.2022.
//

import UIKit

final class SearchCityCell: UITableViewCell {
    static let reuseIdentifier = "SearchCityCell"

    private lazy var mark: UIImageView = {
        let image = UIImage(systemName: "bookmark.fill")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .center
        imageView.tintColor = .systemGray6
        return imageView
    }()
    
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
        contentView.addSubview(mark)
        
        mark.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        mark.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        mark.widthAnchor.constraint(equalToConstant: 50).isActive = true
        mark.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        city.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        city.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        city.leftAnchor.constraint(equalTo: mark.rightAnchor).isActive = true
        city.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5.0).isActive = true
    }
}
