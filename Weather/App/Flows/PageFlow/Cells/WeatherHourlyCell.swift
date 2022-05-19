//
//  WeatherHourlyCell.swift
//  Weather
//
//  Created by Владимир on 19.05.2022.
//

import UIKit

final class WeatherHourlyCell: UITableViewCell {
    static let reuseIdentifier = "WeatherHourlyCell"
    static var height: CGFloat {
        let const = DesignConstants.shared
        let large = 3 * const.padding.large.top
        let small = 3 * const.padding.small.top
        let result = large + small + const.font.medium.lineHeight + const.font.large.lineHeight + const.font.small.lineHeight
        return result.rounded(.up)
    }
    
    private let const = DesignConstants.shared
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .black
        label.font = const.font.small
        label.text = "Почасовой прогноз"
        return label
    }()
    
    private var canvasBlurEffect: UIVisualEffectView = {
        let canvas = UIVisualEffectView()
        canvas.translatesAutoresizingMaskIntoConstraints = false
        canvas.effect = UIBlurEffect(style: .regular)
        canvas.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return canvas
    }()
    
    private var scroll: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .fill
        stack.spacing = const.padding.small.left
        return stack
    }()
    
    
    
    
    // MARK: - Initiation
    //
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureContent()
    }

    required init?(coder: NSCoder) {
        fatalError("📛\tCityCell init(coder:) has not been implemented")
    }

    override func prepareForReuse() {

        super.prepareForReuse()
    }
    
    
    private func configureContent() {
        contentView.backgroundColor = .clear
        
        canvasBlurEffect.frame = contentView.bounds
        
        contentView.addSubview(canvasBlurEffect)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(scroll)
        scroll.addSubview(mainStack)

        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: const.padding.small.top),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: const.padding.medium.left),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -const.padding.small.right),
            descriptionLabel.heightAnchor.constraint(equalToConstant: const.font.small.lineHeight),
            
            scroll.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: const.padding.medium.top),
            scroll.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: const.padding.small.left),
            scroll.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -const.padding.small.right),
            scroll.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            mainStack.topAnchor.constraint(equalTo: scroll.topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: scroll.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: scroll.trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: scroll.bottomAnchor),
            
            mainStack.widthAnchor.constraint(greaterThanOrEqualTo: scroll.widthAnchor)
        ])
    }

    
    public func setup(model: [WeatherHourlyModel]) {
        
        model.forEach { hourly in
            let item = buildItem(model: hourly)
            mainStack.addArrangedSubview(item)
        }
        mainStack.setNeedsLayout()
    }
    
    
    private func buildItem(model: WeatherHourlyModel) -> UIStackView {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.spacing = const.padding.small.top
        
        let time = UILabel()
        time.translatesAutoresizingMaskIntoConstraints = false
        time.textAlignment = .center
        time.textColor = .black
        time.font = const.font.small
        time.text = "11"
        
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleToFill
        icon.tintColor = .black
        icon.image = UIImage(systemName: "cloud.moon.rain")
        
        let temperature = UILabel()
        temperature.translatesAutoresizingMaskIntoConstraints = false
        temperature.textAlignment = .center
        temperature.textColor = .black
        temperature.font = const.font.small
        temperature.text = model.temperature
        
        stack.addArrangedSubview(time)
        stack.addArrangedSubview(icon)
        stack.addArrangedSubview(temperature)
        
        return stack
    }
}
