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
    
    private lazy var unitsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = .white
        label.font = const.font.tiny
        label.text = NSLocalizedString("WeatherView.AirPollutionCell.Units", comment: "Units") + "\u{00B3}"
        return label
    }()
        
    private var airIndicator = AirIndicatorView()
    private var airComponentViews: [UIView] = []

    
    // MARK: Initialization
    //
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("📛 WeatherAirPollutionCell init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        makeLayoutByFrame()
        makeAirComponentsLayoutByFrame()
    }
    
    override func prepareForReuse() {
        airIndicator.setup(aqi: 0)
        airComponentViews.forEach { $0.removeFromSuperview() }
        airComponentViews.removeAll()

        super.prepareForReuse()
    }
}


extension WeatherAirPollutionCell {
    
    private func configureUI() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        contentView.addSubview(canvasBlurEffect)
        contentView.addSubview(icon)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(airIndicator)
        contentView.addSubview(unitsLabel)
        
        setNeedsLayout()
    }
    
    private func makeLayoutByFrame() {
        var origin: CGPoint = .zero
        var size: CGSize = .zero
        
        canvasBlurEffect.frame = contentView.bounds
        
        origin.x = const.padding.medium
        origin.y = const.padding.small
        size.width = const.font.height.small
        size.height = size.width
        icon.frame = CGRect(origin: origin, size: size)
        
        origin.x = icon.frame.maxX + const.padding.small
        size.width = contentView.bounds.width - icon.bounds.width - 2 * const.padding.medium
        descriptionLabel.frame = CGRect(origin: origin, size: size)
        
        size.width = const.size.screen.width / 2
        size.height = size.width / 2
        origin.x = (contentView.bounds.width - size.width) / 2
        origin.y = icon.frame.maxY + const.padding.large
        airIndicator.frame = CGRect(origin: origin, size: size)
        airIndicator.layoutSubviews()
    }
    
    private func makeAirComponentsLayoutByFrame() {
        if !airComponentViews.isEmpty {
            var origin: CGPoint = .zero
            var size: CGSize = .zero
            
            size.width = contentView.bounds.width / 4
            size.height = const.font.height.tiny
            origin.x = contentView.bounds.width - size.width - const.padding.medium
            origin.y = airIndicator.frame.maxY + const.padding.large
            unitsLabel.frame = CGRect(origin: origin, size: size)
            
            size.width = contentView.bounds.width - 2 * const.padding.medium
            size.height = const.font.height.medium
            origin.x = const.padding.medium
            origin.y = unitsLabel.frame.maxY + const.padding.small
            
            airComponentViews.forEach { view in
                view.frame = CGRect(origin: origin, size: size)
                origin.y += size.height + const.padding.small
            }
        }
    }
    

    public func setup(model: WeatherAirPollutionModel) {
        airIndicator.setup(aqi: model.aqi)
    
        model.airComponents.forEach { element in
            let item = ItemAirComponentView()
            item.setup(name: element.description, designation: element.designation, value: element.value.description,
                       color: CAQIEuropeScale.init(for: element).color)
            airComponentViews.append(item)
            contentView.addSubview(item)
        }
//        makeAirComponentsLayoutByFrame()
    }
}


// MARK: - Static class parameters
//
extension WeatherAirPollutionCell {
    
    static let reuseIdentifier = "WeatherAirPollutionCell"
    
    static var height: CGFloat {
        let const = DesignConstants.shared
        
        let padding = const.padding.small + 2 * const.padding.large // + const.padding.small.top
        let font = const.font.height.small + const.font.height.tiny
        let indicator = const.size.screen.width / 4
        
        let result = padding + font + indicator
        return result.rounded(.up)
    }
}
