//
//  SettingsView.swift
//  Weather
//
//  Created by Владимир on 13.04.2022.
//

import UIKit

final class SettingsView: UIView {
    
    private let const = DesignConstants.shared
    
    private(set) var segment: UISegmentedControl = {
        let segment = UISegmentedControl()
        segment.translatesAutoresizingMaskIntoConstraints = false
        segment.backgroundColor = .systemBackground
        segment.insertSegment(withTitle: NSLocalizedString("SettingsView.Title.Cities", comment: "Cities"), at: 0, animated: false)
        segment.insertSegment(withTitle: NSLocalizedString("SettingsView.Title.Settings", comment: "Settings"), at: 1, animated: false)
        segment.selectedSegmentIndex = 0
        return segment
    }()
    
    private(set) var table: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.contentMode = .scaleToFill
        table.separatorStyle = .none
        table.isEditing = false
        table.allowsSelection = false
        table.showsVerticalScrollIndicator = false
        table.keyboardDismissMode = .onDrag
        
        table.register(SearchBarHeader.self, forHeaderFooterViewReuseIdentifier: SearchBarHeader.reuseIdentifier)
        table.register(CityCell.self, forCellReuseIdentifier: CityCell.reuseIdentifier)
        table.register(SearchCityCell.self, forCellReuseIdentifier: SearchCityCell.reuseIdentifier)
        table.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.reuseIdentifier)
    
        return table
    }()
    
    private var emptyView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    // MARK: Initialization
    //
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("📛 SettingsView init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureContent()
    }
    
    
    // MARK: Configure content
    //
    private func configureContent() {
        backgroundColor = .systemRed
        emptyView.backgroundColor = table.backgroundColor
        
        addSubview(segment)
        addSubview(table)
        addSubview(emptyView)

        NSLayoutConstraint.activate([
            segment.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: const.padding.medium.top),
            segment.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            segment.widthAnchor.constraint(equalToConstant: 200),
            segment.heightAnchor.constraint(equalToConstant: 37),

            table.topAnchor.constraint(equalTo: segment.bottomAnchor, constant: const.padding.medium.top),
            table.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            table.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            table.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            emptyView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            emptyView.leftAnchor.constraint(equalTo: leftAnchor),
            emptyView.rightAnchor.constraint(equalTo: rightAnchor),
            emptyView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
