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
        let padding = 4 * const.padding.small.top + const.padding.medium.top
        let font = 4 * const.font.small.lineHeight
        let result = padding + font
        return result.rounded(.up)
    }
    
    private let const = DesignConstants.shared
    
    private var icon: UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFill
        icon.tintColor = .black
        icon.image = UIImage(systemName: "clock")
        return icon
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .black
        label.font = const.font.tiny
        label.text = "Почасовой прогноз"
        return label
    }()
    
//    private var canvasBlurEffect: UIVisualEffectView = {
//        let canvas = UIVisualEffectView()
////        canvas.backgroundColor = .systemGray4
//        canvas.effect = UIBlurEffect(style: .regular)
//        canvas.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        return canvas
//    }()
    
    private var canvasBlurEffect = UIVisualEffectView()

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
        stack.spacing = const.padding.medium.left
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
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        canvasBlurEffect.frame = contentView.bounds
        canvasBlurEffect.effect = UIBlurEffect(style: .regular)
        canvasBlurEffect.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        contentView.addSubview(canvasBlurEffect)
        contentView.addSubview(icon)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(scroll)
        scroll.addSubview(mainStack)

        NSLayoutConstraint.activate([
            icon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: const.padding.small.top),
            icon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: const.padding.small.left),
            icon.widthAnchor.constraint(equalToConstant: const.font.small.lineHeight),
            icon.heightAnchor.constraint(equalToConstant: const.font.small.lineHeight),
            
            descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: const.padding.small.top),
            descriptionLabel.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: const.padding.small.left),
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
        time.font = const.font.tiny
        time.text = model.time
        
        let icon = UIImageView(frame: CGRect(origin: .zero, size: const.size.icon))
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFit
        icon.image = model.icon

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
