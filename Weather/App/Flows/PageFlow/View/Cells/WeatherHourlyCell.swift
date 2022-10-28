//
//  WeatherHourlyCell.swift
//  Weather
//
//  Created by Владимир on 19.05.2022.
//

import UIKit

final class WeatherHourlyCell: UITableViewCell {
    
    private let const = DesignConstants.shared
    
    private var icon: UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFill
        icon.tintColor = .white
        icon.image = UIImage(systemName: "clock")
        return icon
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .white
        label.font = const.font.small
        label.text = NSLocalizedString("WeatherView.HourlyCell.DescriptionLabel", comment: "Hourly forecast")
        return label
    }()

    private var scroll: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.showsVerticalScrollIndicator = false
        scroll.contentMode = .center
        return scroll
    }()
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .fill
        stack.spacing = const.padding.medium
        return stack
    }()
    
    private var canvasBlurEffect: UIVisualEffectView = {
        let canvas = UIVisualEffectView()
        canvas.effect = UIBlurEffect(style: .regular)
        canvas.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return canvas
    }()
    
    
    // MARK: Initialization
    //
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("📛 WeatherHourlyCell init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        mainStack.arrangedSubviews.forEach { view in
            view.removeFromSuperview()
        }
        super.prepareForReuse()
    }
}


// MARK: - Support methods
//
extension WeatherHourlyCell {
    
    private func configureUI() {
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        canvasBlurEffect.frame = contentView.bounds
        
        contentView.addSubview(canvasBlurEffect)
        contentView.addSubview(icon)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(scroll)
        scroll.addSubview(mainStack)

        NSLayoutConstraint.activate([
            icon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: const.padding.small),
            icon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: const.padding.medium),
            icon.widthAnchor.constraint(equalToConstant: const.font.height.small),
            icon.heightAnchor.constraint(equalToConstant: const.font.height.small),
            
            descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: const.padding.small),
            descriptionLabel.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: const.padding.small),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -const.padding.small),
            descriptionLabel.heightAnchor.constraint(equalToConstant: const.font.height.small),
            
            scroll.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: const.padding.medium),
            scroll.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: const.padding.small),
            scroll.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -const.padding.small),
            scroll.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -const.padding.small),
            
            mainStack.topAnchor.constraint(equalTo: scroll.topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: scroll.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: scroll.trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: scroll.bottomAnchor)
        ])
    }
    
    private func buildItem(model: WeatherHourlyModel) -> UIStackView {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .center
        stack.contentMode = .scaleToFill
        stack.spacing = 7
        
        let time = UILabel()
        time.translatesAutoresizingMaskIntoConstraints = false
        time.textAlignment = .center
        time.textColor = .white
        time.font = const.font.small
        time.text = model.time
        
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.clipsToBounds = true
        icon.contentMode = .scaleAspectFit
        icon.image = model.icon
        icon.setContentHuggingPriority(UILayoutPriority(rawValue: 249), for: .horizontal)
        icon.setContentHuggingPriority(UILayoutPriority(rawValue: 250), for: .vertical)
        icon.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 749), for: .horizontal)
        icon.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 750), for: .vertical)

        let temperature = UILabel()
        temperature.translatesAutoresizingMaskIntoConstraints = false
        temperature.textAlignment = .center
        temperature.textColor = .white
        temperature.font = const.font.small
        temperature.text = model.temperature
        
        stack.addArrangedSubview(time)
        stack.addArrangedSubview(icon)
        stack.addArrangedSubview(temperature)
        
        return stack
    }
    
    public func setup(model: [WeatherHourlyModel]) {
        model.forEach { hourly in
            let item = buildItem(model: hourly)
            mainStack.addArrangedSubview(item)
        }
        mainStack.setNeedsLayout()
    }
}


// MARK: - Static class parameters
//
extension WeatherHourlyCell {
    
    static let reuseIdentifier = "WeatherHourlyCell"
    
    static var height: CGFloat {
        let const = DesignConstants.shared
        
        let padding = 4 * const.padding.small + const.padding.medium
        let font = 3 * const.font.height.small + const.font.height.medium
        
        let result = padding + font
        return result.rounded(.up)
    }
}
