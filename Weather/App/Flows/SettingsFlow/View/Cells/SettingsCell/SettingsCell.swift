//
//  SettingsCell.swift
//  Weather
//
//  Created by Владимир on 16.04.2022.
//

import UIKit

final class SettingsCell: UITableViewCell {
    static let reuseIdentifier = "SettingsCell"

    private let padding = DesignConstants.shared.padding
    
    private var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .label
        label.font = .systemFont(ofSize: UIFont.labelFontSize)
        return label
    }()

    private(set) var segmentControl: UISegmentedControl = {
        let segment = UISegmentedControl()
        segment.translatesAutoresizingMaskIntoConstraints = false
        return segment
    }()

    
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

    
    // MARK: Initialization
    ///
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("📛 SettingsCell init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        label.text = nil
        segmentControl.removeAllSegments()
        segmentControl.selectedSegmentIndex = 0
        viewModel = nil
        super.prepareForReuse()
    }
}
 

// MARK: - Support methods
//
extension SettingsCell {

    private func configureUI() {
        contentView.addSubview(segmentControl)
        contentView.addSubview(label)

        NSLayoutConstraint.activate([
            segmentControl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            segmentControl.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -padding.small),
            segmentControl.widthAnchor.constraint(equalToConstant: 175),
            segmentControl.heightAnchor.constraint(equalToConstant: 37),

            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: padding.medium),
            label.rightAnchor.constraint(equalTo: segmentControl.leftAnchor, constant: -padding.small)
        ])
    }
}


// MARK: - Actions extension
//
extension SettingsCell {
    
    @objc
    func changed(sender: UISegmentedControl) {
        viewModel?.save(selected: sender.selectedSegmentIndex)
    }
}
