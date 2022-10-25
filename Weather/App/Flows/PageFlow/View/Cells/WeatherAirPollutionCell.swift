//
//  WeatherAirPollutionCell.swift
//  Weather
//
//  Created by Владимир on 19.10.2022.
//

import UIKit

final class WeatherAirPollutionCell: UITableViewCell {
    
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
        icon.image = UIImage(systemName: "aqi.medium")
        return icon
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.font = const.font.small
        label.text = NSLocalizedString("WeatherView.AirPollutionCell.DescriptionLabel", comment: "Air")
        return label
    }()
    
    private var airIndicator = AirIndicatorView()
    
    
    // MARK: Initialization
    //
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureContent()
    }

    required init?(coder: NSCoder) {
        fatalError("📛 WeatherAirPollutionCell init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        makeLayoutByFrame()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}


extension WeatherAirPollutionCell {
    
    private func configureContent() {
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        contentView.addSubview(canvasBlurEffect)
        contentView.addSubview(icon)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(airIndicator)
        
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
        
        size.width = const.screen.width / 2
        size.height = size.width / 2
        origin.x = (contentView.bounds.width - size.width) / 2
        origin.y = icon.frame.maxY + const.padding.large.top
        
        airIndicator.frame = CGRect(origin: origin, size: size)
        airIndicator.layoutSubviews()
    }
    
    
    public func setup(model: WeatherAirPollutionModel) {
        airIndicator.setup(aqi: model.aqi)
    }
}


// MARK: - Static class parameters
//
extension WeatherAirPollutionCell {
    
    static let reuseIdentifier = "WeatherAirPollutionCell"
    
    static var height: CGFloat {
        let const = DesignConstants.shared
        
        let padding =  2 * const.padding.small.top + const.padding.large.top + const.padding.medium.bottom
        let font = const.font.height.small
        let body = const.screen.width / 4
        
        let result = padding + font + body
        return result.rounded(.up)
    }
}
