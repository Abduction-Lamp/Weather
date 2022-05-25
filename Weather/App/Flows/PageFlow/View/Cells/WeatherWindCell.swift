//
//  WeatherWindCell.swift
//  Weather
//
//  Created by Владимир on 24.05.2022.
//

import UIKit

final class WeatherWindCell: UITableViewCell {
    static let reuseIdentifier = "WeatherWindCell"
    static let height: CGFloat = 200
    
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
        icon.image = UIImage(systemName: "wind")
        return icon
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.font = const.font.tiny
        label.text = "Ветер"
        return label
    }()
    
    private var compass = CompassView()
    
    
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

        super.prepareForReuse()
    }
}


// MARK: - Support methods
//
extension WeatherWindCell {
    
    private func configureContent() {
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        contentView.addSubview(canvasBlurEffect)
        contentView.addSubview(icon)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(compass)

        setNeedsLayout()
    }
    
    private func makeLayoutByFrame() {
        canvasBlurEffect.frame = contentView.bounds
        
        icon.frame = CGRect(x: const.padding.medium.left,
                            y: const.padding.small.top,
                            width: const.font.height.small,
                            height: const.font.height.small)
        descriptionLabel.frame = CGRect(x: icon.frame.maxX + const.padding.medium.left,
                                        y: const.padding.small.top,
                                        width: contentView.bounds.width - icon.frame.maxX - 2 * const.padding.medium.left,
                                        height: const.font.height.small)
        compass.frame = CGRect(x: const.padding.medium.left,
                               y: icon.frame.maxY + const.padding.medium.top,
                               width: contentView.bounds.height - icon.frame.maxY - 2 * const.padding.medium.top,
                               height: contentView.bounds.height - icon.frame.maxY - 2 * const.padding.medium.top)
        compass.layoutSubviews()
    }
}
