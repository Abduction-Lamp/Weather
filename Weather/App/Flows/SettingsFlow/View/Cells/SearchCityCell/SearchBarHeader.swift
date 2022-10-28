//
//  SearchBarHeader.swift
//  Weather
//
//  Created by Владимир on 09.06.2022.
//

import UIKit

final class SearchBarHeader: UITableViewHeaderFooterView {

    private let font = DesignConstants.shared.font
    private let padding = DesignConstants.shared.padding
    
    private(set) var backButton: UIButton = {
        let button = UIButton()
        let title = NSLocalizedString("SettingsView.SearchCityCell.BackButton", comment: "Back Button")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.systemRed, for: .highlighted)
        return button
    }()
    
    private(set) var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        let placeholder = NSLocalizedString("SettingsView.SearchCityCell.Search", comment: "placeholder")
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchBarStyle = .minimal
        searchBar.autocapitalizationType = .words
        searchBar.returnKeyType = .search
        searchBar.enablesReturnKeyAutomatically = false
        searchBar.placeholder = placeholder
        return searchBar
    }()

    
    // MARK: Initialization
    //
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("📛 SearchBarHeader init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        searchBar.text = nil
        super.prepareForReuse()
    }
}


// MARK: - Support methods
//
extension SearchBarHeader {
    
    private func configureUI() {
        contentView.backgroundColor = .clear
        
        contentView.addSubview(backButton)
        contentView.addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding.medium),
            backButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding.medium),
            backButton.widthAnchor.constraint(equalToConstant: 100),
            backButton.heightAnchor.constraint(equalToConstant: font.height.large),
            
            searchBar.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: padding.small),
            searchBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            searchBar.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding.medium)
        ])
    }
    
    public func setup() {
        searchBar.becomeFirstResponder()
    }
}


// MARK: - Static class parameters
//
extension SearchBarHeader {
    
    static let reuseIdentifier = "SearchBarHeader"
    
    static var height: CGFloat {
        let padding = 2 * DesignConstants.shared.padding.medium + DesignConstants.shared.padding.small
        let size: CGFloat = 36 + DesignConstants.shared.font.height.large
        return (padding + size).rounded(.up)
    }
    
}
