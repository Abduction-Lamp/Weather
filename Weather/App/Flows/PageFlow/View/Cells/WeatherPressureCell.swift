//
//  WeatherPressureCell.swift
//  Weather
//
//  Created by Владимир on 02.06.2022.
//

import UIKit

final class WeatherPressureCell: UITableViewCell {
    static let reuseIdentifier = "WeatherPressureCell"
    static let height: CGFloat = 180
    
    private let const = DesignConstants.shared
    
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
        icon.image = UIImage(systemName: "barometer")
        return icon
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.font = const.font.small
        label.text = "Атмосферное давление"
        return label
    }()
    
    private var barometer = BarometerView()
 
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.font = const.font.small
        label.text = ""
        return label
    }()
    
    private lazy var infoText: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.showsVerticalScrollIndicator = false
        textView.showsHorizontalScrollIndicator = false
        textView.textAlignment = .left
        textView.backgroundColor = .clear
        textView.textColor = .white
        textView.font = const.font.tiny
        textView.text = ""
        return textView
    }()
    
    // MARK: Initialization
    ///
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureContent()
    }

    required init?(coder: NSCoder) {
        fatalError("📛\tWeatherWindCell init(coder:) has not been implemented")
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
extension WeatherPressureCell {
    
    private func configureContent() {
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        contentView.addSubview(canvasBlurEffect)
        contentView.addSubview(icon)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(barometer)
        contentView.addSubview(infoLabel)
        contentView.addSubview(infoText)
        
        setNeedsLayout()
    }
    
    private func makeLayoutByFrame() {
        var origin: CGPoint = .zero
        var size: CGSize = .zero
        
        canvasBlurEffect.frame = contentView.bounds
        
        origin.x = const.padding.medium.left
        origin.y = const.padding.small.top
        size.width = const.font.height.small
        size.height = size.width
        icon.frame = CGRect(origin: origin, size: size)
        
        origin.x = icon.frame.maxX + const.padding.small.left
        size.width = contentView.bounds.width - icon.frame.maxX - 2 * const.padding.medium.left
        descriptionLabel.frame = CGRect(origin: origin, size: size)
        
        origin.x = const.padding.medium.left
        origin.y = icon.frame.maxY + const.padding.medium.top
        size.width = contentView.bounds.height - icon.frame.maxY - 2 * const.padding.medium.top
        size.height = size.width
        barometer.frame = CGRect(origin: origin, size: size)
        barometer.layoutSubviews()

        origin.x = barometer.frame.maxX + const.padding.medium.left
        size.width = contentView.bounds.width - barometer.frame.maxX - 2 * const.padding.medium.top
        size.height = contentView.bounds.height - origin.y - const.padding.medium.bottom
        infoText.frame = CGRect(origin: origin, size: size)
    }
    
    
    public func setup(model: WeatherPressureModel) {
        infoText.text = model.text
        barometer.setup(measurement: model.measurement, pressure: model.pressure, units: model.units)
    }
}
