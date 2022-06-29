//
//  WeatherPressureAndHumidityCell.swift
//  Weather
//
//  Created by Владимир on 02.06.2022.
//

import UIKit

final class WeatherPressureAndHumidityCell: UITableViewCell {
    static let reuseIdentifier = "WeatherPressureAndHumidityCell"
    static let height: CGFloat = 180
    
    private let const = DesignConstants.shared
    
    
    // Pressure
    private var pressureView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    private var pressureBlurEffect: UIVisualEffectView = {
        let canvas = UIVisualEffectView()
        canvas.effect = UIBlurEffect(style: .regular)
        canvas.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return canvas
    }()
    
    private var pressureIcon: UIImageView = {
        let icon = UIImageView()
        icon.contentMode = .scaleAspectFill
        icon.tintColor = .white
        icon.image = UIImage(systemName: "gauge")
        return icon
    }()
    
    private lazy var pressureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.font = const.font.small
        label.text = NSLocalizedString("WeatherView.PressureCell.DescriptionLabel", comment: "Pressure")
        return label
    }()
    
    private var barometer = BarometerView()
    
    
    // Humidity
    private var humidityView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    private var humidityBlurEffect: UIVisualEffectView = {
        let canvas = UIVisualEffectView()
        canvas.effect = UIBlurEffect(style: .regular)
        canvas.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return canvas
    }()
    
    private var humidityIcon: UIImageView = {
        let icon = UIImageView()
        icon.contentMode = .scaleAspectFill
        icon.tintColor = .white
        icon.image = UIImage(systemName: "humidity")
        return icon
    }()
    
    private lazy var humidityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.font = const.font.small
        label.text = NSLocalizedString("WeatherView.HumidityCell.DescriptionLabel", comment: "Humidity")
        return label
    }()
    
    private lazy var humidityValueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.font = const.font.large
        return label
    }()
    
    private lazy var dewPointLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.numberOfLines = 2
        label.font = const.font.tiny
        return label
    }()
    
    
    // MARK: Initialization
    //
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
        humidityValueLabel.text = nil
        dewPointLabel.text = nil
        super.prepareForReuse()
    }
}


// MARK: - Support methods
//
extension WeatherPressureAndHumidityCell {
    
    private func configureContent() {
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        humidityView.addSubview(humidityBlurEffect)
        humidityView.addSubview(humidityIcon)
        humidityView.addSubview(humidityLabel)
        humidityView.addSubview(humidityValueLabel)
        humidityView.addSubview(dewPointLabel)
        
        pressureView.addSubview(pressureBlurEffect)
        pressureView.addSubview(pressureIcon)
        pressureView.addSubview(pressureLabel)
        pressureView.addSubview(barometer)
        
        contentView.addSubview(humidityView)
        contentView.addSubview(pressureView)
        
        setNeedsLayout()
    }
    
    private func makeLayoutByFrame() {
        var origin: CGPoint = .zero
        var size: CGSize = .zero
        
        size = CGSize(width: (contentView.bounds.width - const.padding.medium.left)/2, height: WeatherPressureAndHumidityCell.height)
        humidityView.frame = CGRect(origin: origin, size: size)
        origin.x = humidityView.frame.maxX + const.padding.medium.left
        pressureView.frame = CGRect(origin: origin, size: size)
        
        humidityBlurEffect.frame = CGRect(origin: .zero, size: size)
        pressureBlurEffect.frame = CGRect(origin: .zero, size: size)
        
        origin.x = const.padding.medium.left
        origin.y = const.padding.small.top
        size.width = const.font.height.small
        size.height = size.width
        humidityIcon.frame = CGRect(origin: origin, size: size)
        pressureIcon.frame = CGRect(origin: origin, size: size)
        
        origin.x = humidityIcon.frame.maxX + const.padding.small.left
        size.width = humidityView.bounds.width - humidityIcon.bounds.maxX - 2 * const.padding.medium.left
        humidityLabel.frame = CGRect(origin: origin, size: size)
        
        origin.x = pressureIcon.frame.maxX + const.padding.small.left
        size.width = pressureView.bounds.width - pressureIcon.bounds.maxX - 2 * const.padding.medium.left
        pressureLabel.frame = CGRect(origin: origin, size: size)
        
        size.width = humidityView.bounds.width - 2 * const.padding.medium.left
        size.height = const.font.height.large
        origin.x = const.padding.medium.left
        origin.y = humidityLabel.frame.maxY + const.padding.medium.top
        humidityValueLabel.frame = CGRect(origin: origin, size: size)
        
        size.height = 2 * const.font.height.tiny
        origin.x = const.padding.medium.left
        origin.y = humidityView.frame.height - const.padding.medium.bottom - size.height
        dewPointLabel.frame = CGRect(origin: origin, size: size)
        
        size.width = min(pressureView.bounds.width - 2 * const.padding.medium.left,
                         pressureView.bounds.height - 2 * const.padding.medium.left - pressureLabel.frame.maxY)
        size.height = size.width
        origin.x = pressureView.bounds.midX - size.width/2
        origin.y = pressureLabel.frame.maxY + const.padding.medium.top
        barometer.frame = CGRect(origin: origin, size: size)
        barometer.layoutSubviews()
    }
    
    
    public func setup(model: WeatherPressureAndHumidityModel) {
        barometer.setup(measurement: model.measurement, pressure: model.pressure, units: model.units)
        humidityValueLabel.text = model.humidity
        dewPointLabel.text = model.dewPoint
    }
}
