//
//  SearchCityCell.swift
//  Weather
//
//  Created by Владимир on 26.04.2022.
//

import UIKit

final class SearchCityCell: UITableViewCell {
    static let reuseIdentifier = "SearchCityCell"
    
    private let const = DesignConstants.shared

    private lazy var mark: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "bookmark.fill"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .center
        imageView.tintColor = .clear
        return imageView
    }()
    
    private lazy var city: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .black
        label.font = .systemFont(ofSize: UIFont.labelFontSize)
        return label
    }()

    
    var viewModel: SearchCityCellViewModelProtocol? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            city.text = viewModel.data.city
            if viewModel.isSaved {
                mark.tintColor = .systemRed
                city.font = .boldSystemFont(ofSize: UIFont.labelFontSize)
            } else {
                mark.tintColor = .systemGray6
                city.font = .systemFont(ofSize: UIFont.labelFontSize)
            }
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
        mark.tintColor = .clear
        viewModel = nil
        super.prepareForReuse()
    }
    
    
    // MARK: - Configure Content & Set Data
    //
    private func configureContent() {
        contentView.backgroundColor = .white
        
        contentView.addSubview(city)
        contentView.addSubview(mark)
        
        NSLayoutConstraint.activate([
            mark.topAnchor.constraint(equalTo: contentView.topAnchor),
            mark.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            mark.widthAnchor.constraint(equalToConstant: 50),
            mark.heightAnchor.constraint(equalToConstant: 50),
            
            city.topAnchor.constraint(equalTo: contentView.topAnchor),
            city.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            city.leftAnchor.constraint(equalTo: mark.rightAnchor),
            city.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -const.padding.small.right)
        ])
    }
}
