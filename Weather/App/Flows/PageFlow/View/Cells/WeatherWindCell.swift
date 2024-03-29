//
//  WeatherWindCell.swift
//  Weather
//
//  Created by Владимир on 24.05.2022.
//

import UIKit

final class WeatherWindCell: UITableViewCell {

    private let font = DesignConstants.shared.font
    private let padding = DesignConstants.shared.padding
    
    private var canvasBlurEffect: UIVisualEffectView = {
        let canvas = UIVisualEffectView()
        canvas.effect = UIBlurEffect(style: .regular)
        canvas.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return canvas
    }()
    
    private var icon: UIImageView = {
        let icon = UIImageView()
        icon.contentMode = .scaleAspectFill
        icon.tintColor = .white
        icon.image = UIImage(systemName: "wind")
        return icon
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.font = font.small
        label.text = NSLocalizedString("WeatherView.WindCell.DescriptionLabel", comment: "Wind")
        return label
    }()
    
    private var compass = CompassView()
 
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.font = font.small
        label.text = ""
        return label
    }()
    
    private lazy var infoText: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isSelectable = false
        textView.showsVerticalScrollIndicator = false
        textView.showsHorizontalScrollIndicator = false
        textView.textAlignment = .natural
        textView.backgroundColor = .clear
        textView.textColor = .white
        textView.font = font.small
        textView.text = ""
        return textView
    }()
    
    // MARK: Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("📛 WeatherWindCell init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        makeLayoutByFrame()
    }
    
    override func prepareForReuse() {
        infoLabel.text = nil
        infoText.text = nil
        super.prepareForReuse()
    }
}


// MARK: - Support methods
//
extension WeatherWindCell {
    
    private func configureUI() {
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        contentView.addSubview(canvasBlurEffect)
        contentView.addSubview(icon)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(compass)
        contentView.addSubview(infoLabel)
        contentView.addSubview(infoText)
        
        setNeedsLayout()
    }
    
    private func makeLayoutByFrame() {
        var origin: CGPoint = .zero
        var size: CGSize = .zero
        
        canvasBlurEffect.frame = contentView.bounds
        
        origin.x = padding.medium
        origin.y = padding.small
        size.width = font.height.small
        size.height = size.width
        icon.frame = CGRect(origin: origin, size: size)
        
        origin.x = icon.frame.maxX + padding.small
        size.width = contentView.bounds.width - icon.frame.maxX - 2 * padding.medium
        descriptionLabel.frame = CGRect(origin: origin, size: size)
        
        origin.x = padding.medium
        origin.y = icon.frame.maxY + padding.medium
        size.width = contentView.bounds.height - icon.frame.maxY - 2 * padding.medium
        size.height = size.width
        compass.frame = CGRect(origin: origin, size: size)
        compass.layoutSubviews()

        origin.x = compass.frame.maxX + padding.medium
        size.width = contentView.bounds.width - compass.frame.maxX - 2 * padding.medium
        size.height = contentView.bounds.height - origin.y - padding.medium
        infoText.frame = CGRect(origin: origin, size: size)
    }
    
    
    public func setup(model: WeatherWindModel) {
        infoText.text = model.info
        compass.setup(measurement: model.measurement, degrees: model.degrees, units: model.units)
    }
}


// MARK: - Static class parameters
//
extension WeatherWindCell {
    
    static let reuseIdentifier = "WeatherWindCell"
    static let height: CGFloat = 180
}
