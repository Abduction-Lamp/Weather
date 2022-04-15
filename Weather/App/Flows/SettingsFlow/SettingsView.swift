//
//  SettingsView.swift
//  Weather
//
//  Created by Владимир on 13.04.2022.
//

import UIKit

final class SettingsView: UIView {
    
    private(set) var segment: UISegmentedControl = {
        let segment = UISegmentedControl()
        segment.translatesAutoresizingMaskIntoConstraints = false
        segment.backgroundColor = .systemBackground
        segment.insertSegment(withTitle: "Города", at: 0, animated: false)
        segment.insertSegment(withTitle: "Настройки", at: 1, animated: false)
        segment.selectedSegmentIndex = 0
        return segment
    }()

    private(set) var table: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.contentMode = .scaleToFill
        table.separatorStyle = .singleLine
        table.isEditing = false
        table.allowsSelection = false
        table.showsVerticalScrollIndicator = false
        table.tableFooterView = UIView()

//        table.register(SettingsCitiesHeader.self, forHeaderFooterViewReuseIdentifier: SettingsCitiesHeader.reuseIdentifier)
        table.register(SettingsCityCell.self, forCellReuseIdentifier: SettingsCityCell.reuseIdentifier)
//        table.register(SettingsSegmentCell.self, forCellReuseIdentifier: SettingsSegmentCell.reuseIdentifier)

        return table
    }()
    

    // MARK: - Initiation
    //
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        configureContent()
    }

    
    // MARK: - Configure Content
    //
    private func configureContent() {
        self.backgroundColor = .systemRed
        self.addSubview(segment)
        self.addSubview(table)

        segment.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        segment.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor).isActive = true
        segment.widthAnchor.constraint(equalToConstant: 200).isActive = true
        segment.heightAnchor.constraint(equalToConstant: 35).isActive = true

        table.topAnchor.constraint(equalTo: segment.bottomAnchor, constant: 20).isActive = true
        table.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor).isActive = true
        table.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor).isActive = true
        table.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
