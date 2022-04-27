//
//  SettingsCell.swift
//  Weather
//
//  Created by Владимир on 16.04.2022.
//

import UIKit

final class SettingsCell: UITableViewCell {
    static let reuseIdentifier = "SettingsCell"

    private var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: UIFont.labelFontSize)
        return label
    }()

    private(set) var segmentControl: UISegmentedControl = {
        let segment = UISegmentedControl()
        segment.translatesAutoresizingMaskIntoConstraints = false
        return segment
    }()


    // MARK: - Initiation
    //
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureContent()
    }

    required init?(coder: NSCoder) {
        fatalError("📛\tSettingsCell init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        label.text = nil
        segmentControl.removeAllSegments()
        segmentControl.selectedSegmentIndex = 0
        viewModel = nil
    }

    
    // MARK: - Configure Content & Set Data
    //
    private func configureContent() {
        contentView.backgroundColor = .white
        contentView.addSubview(segmentControl)
        contentView.addSubview(label)

        segmentControl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        segmentControl.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -7).isActive = true
        segmentControl.widthAnchor.constraint(equalToConstant: 144).isActive = true
        segmentControl.heightAnchor.constraint(equalToConstant: 35).isActive = true

        label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15).isActive = true
        label.rightAnchor.constraint(equalTo: segmentControl.leftAnchor, constant: -5).isActive = true
    }

    
    var viewModel: SettingsCellViewModelProtocol? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }

            label.text = viewModel.data.label
            for (index, title) in viewModel.data.items.enumerated() {
                segmentControl.insertSegment(withTitle: title, at: index, animated: false)
            }
            segmentControl.selectedSegmentIndex = viewModel.selected
            segmentControl.addTarget(self, action: #selector(changed(sender: )), for: .valueChanged)
        }
    }
}
 

extension SettingsCell {
    
    @objc
    func changed(sender: UISegmentedControl) {
        viewModel?.save(selected: sender.selectedSegmentIndex)
    }
}
