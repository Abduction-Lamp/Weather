//
//  WeatherDailyCell.swift
//  Weather
//
//  Created by Владимир on 19.05.2022.
//

import UIKit

final class WeatherDailyCell: UITableViewCell {
    
    private let const = DesignConstants.shared
    
    private var icon: UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFill
        icon.tintColor = .white
        icon.image = UIImage(systemName: "calendar")
        return icon
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .white
        label.font = const.font.small
        label.text = NSLocalizedString("WeatherView.DailyCell.DescriptionLabel", comment: "Forecast for the week")
        return label
    }()
        
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .fill
        stack.spacing = const.padding.small
        return stack
    }()
    
    private var canvasBlurEffect: UIVisualEffectView = {
        let canvas = UIVisualEffectView()
        canvas.translatesAutoresizingMaskIntoConstraints = false
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
        fatalError("📛 WeatherDailyCell init(coder:) has not been implemented")
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
extension WeatherDailyCell {
    
    private func configureUI() {
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        canvasBlurEffect.frame = contentView.bounds
        
        contentView.addSubview(canvasBlurEffect)
        contentView.addSubview(icon)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(mainStack)

        NSLayoutConstraint.activate([
            icon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: const.padding.small),
            icon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: const.padding.medium),
            icon.widthAnchor.constraint(equalToConstant: const.font.height.small),
            icon.heightAnchor.constraint(equalToConstant: const.font.height.small),
            
            descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: const.padding.small),
            descriptionLabel.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: const.padding.small),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -const.padding.small),
            descriptionLabel.heightAnchor.constraint(equalToConstant: const.font.height.small),
            
            mainStack.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: const.padding.medium),
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -const.padding.small)
        ])
    }

    private func buildItem(model: WeatherDailyModel) -> UIView {
        let viewFrame = CGRect(origin: .zero,
                               size: CGSize(width: contentView.frame.width,
                                            height: (2 * const.padding.small + const.font.medium.lineHeight)))
        let view = UIView(frame: viewFrame)
        view.translatesAutoresizingMaskIntoConstraints = false

        let day = UILabel()
        day.translatesAutoresizingMaskIntoConstraints = false
        day.textAlignment = .left
        day.textColor = .white
        day.font = const.font.small
        day.text = model.day
        
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFit
        icon.image = model.icon
        
        let temperature = UILabel()
        temperature.translatesAutoresizingMaskIntoConstraints = false
        temperature.textAlignment = .right
        temperature.textColor = .white
        temperature.font = const.font.small
        temperature.text = model.temperature
        
        view.addSubview(day)
        view.addSubview(icon)
        view.addSubview(temperature)

        NSLayoutConstraint.activate([
            icon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            icon.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            icon.widthAnchor.constraint(equalToConstant: const.size.icon.width),
            icon.heightAnchor.constraint(equalToConstant: const.size.icon.height),
            
            day.topAnchor.constraint(equalTo: view.topAnchor, constant: const.padding.small),
            day.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: const.padding.medium),
            day.trailingAnchor.constraint(equalTo: icon.leadingAnchor, constant: -const.padding.small),
            day.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -const.padding.small),
            
            temperature.topAnchor.constraint(equalTo: view.topAnchor, constant: const.padding.small),
            temperature.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: const.padding.small),
            temperature.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -const.padding.medium),
            temperature.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -const.padding.small)
        ])
        
        return view
    }
    
    public func setup(model: [WeatherDailyModel]) {
        model.forEach { daily in
            let item = buildItem(model: daily)
            mainStack.addArrangedSubview(item)
        }
        mainStack.setNeedsLayout()
    }
}


// MARK: - Static class parameters
//
extension WeatherDailyCell {
    
    static let reuseIdentifier = "WeatherDailyCell"
    
    static var height: CGFloat {
        let const = DesignConstants.shared
        let result = 8 * (2 * const.padding.small + const.font.medium.lineHeight) + const.padding.medium
        return result.rounded(.up)
    }
}
