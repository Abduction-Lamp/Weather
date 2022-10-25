//
//  SearchBarHeader.swift
//  Weather
//
//  Created by Владимир on 09.06.2022.
//

import UIKit

final class SearchBarHeader: UITableViewHeaderFooterView {
    static let reuseIdentifier = "SearchBarHeader"
    static var height: CGFloat {
        let padding = 2 * DesignConstants.shared.padding.medium.top + DesignConstants.shared.padding.small.top
        let size: CGFloat = 36 + DesignConstants.shared.font.height.large
        return (padding + size).rounded(.up)
    }
    
    private let const = DesignConstants.shared
    
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
        
        configureContent()
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
    
    private func configureContent() {
        contentView.backgroundColor = .clear
        
        contentView.addSubview(backButton)
        contentView.addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: const.padding.medium.top),
            backButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -const.padding.medium.right),
            backButton.widthAnchor.constraint(equalToConstant: 100),
            backButton.heightAnchor.constraint(equalToConstant: const.font.height.large),
            
            searchBar.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: const.padding.small.top),
            searchBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            searchBar.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -const.padding.medium.bottom)
        ])
    }
    
    public func setup() {
        searchBar.becomeFirstResponder()
    }
}
