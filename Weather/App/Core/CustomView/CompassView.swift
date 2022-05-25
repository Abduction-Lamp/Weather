//
//  CompassView.swift
//  Weather
//
//  Created by Владимир on 24.05.2022.
//

import UIKit

final class CompassView: UIView {

    private let const = DesignConstants.shared
    
    private let circle = CAReplicatorLayer()
    private let graduation = CAReplicatorLayer()
    
    private let dot = CALayer()
    private let level = CALayer()
    
    
    private let dial: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .clear
        return view
    }()
    
    private let north: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white.withAlphaComponent(0.7)
        label.font = .boldSystemFont(ofSize: UIFont.labelFontSize)
        label.text = "C"
        return label
    }()
    
    private let south: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white.withAlphaComponent(0.7)
        label.font = .boldSystemFont(ofSize: UIFont.labelFontSize)
        label.text = "Ю"
        return label
    }()
    
    private let west: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white.withAlphaComponent(0.7)
        label.font = .boldSystemFont(ofSize: UIFont.labelFontSize)
        label.text = "З"
        return label
    }()
    
    private let east: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white.withAlphaComponent(0.7)
        label.font = .boldSystemFont(ofSize: UIFont.labelFontSize)
        label.text = "В"
        return label
    }()
    
    private lazy var value: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = const.font.medium
        return label
    }()
    private lazy var units: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = const.font.small
        return label
    }()
    
    private let arrow = CALayer()
    private let tip = CALayer()
        
    private var color = UIColor.white
    private var attributes: [NSAttributedString.Key: Any] = [:]


    // MARK: Initialization
    ///
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        buildContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("📛\tCompassView init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        dotConfiguration()
        circleConfiguration(dotCount: 120)
        
        levelConfiguration()
        graduationConfiguration(dotCount: 8)
        
        textConfiguration()
        
        arrowConfiguration(degrees: 90)
        dialConfiguration(measurement: "21")
    }
    
    
    // MARK: Configuration content
    ///
    private func buildContent() {
        backgroundColor = .clear
        attributes[.foregroundColor] = color

        circle.addSublayer(dot)
        layer.addSublayer(circle)
        
        graduation.addSublayer(level)
        layer.addSublayer(graduation)
                
        addSubview(north)
        addSubview(south)
        addSubview(west)
        addSubview(east)
        
        arrow.addSublayer(tip)
        
        dial.layer.addSublayer(arrow)
        dial.addSubview(value)
        dial.addSubview(units)
        
        addSubview(dial)
    }
    
    private func dotConfiguration() {
        let size = CGSize(width: 1, height: 7)
        
        dot.bounds = CGRect(origin: .zero, size: size)
        dot.position = CGPoint(x: bounds.midY, y: const.padding.small.top)
        
        dot.masksToBounds = true
        dot.backgroundColor = color.cgColor
        dot.opacity = 0.5
    }
    
    private func levelConfiguration() {
        let size = CGSize(width: 2, height: 7)
        
        level.bounds = CGRect(origin: .zero, size: size)
        level.position = CGPoint(x: bounds.midY, y: const.padding.small.top)
        
        level.masksToBounds = true
        level.backgroundColor = color.cgColor
        level.opacity = 1
    }
    
    private func graduationConfiguration(dotCount: Int) {
        graduation.frame = bounds
        graduation.masksToBounds = true
        
        graduation.instanceCount = dotCount
        graduation.instanceColor = color.cgColor

        let angle = (Float.pi * 2)/Float(dotCount)
        graduation.instanceTransform = CATransform3DMakeRotation(CGFloat(angle), 0.0, 0.0, 1.0)
    }

    private func circleConfiguration(dotCount: Int) {
        circle.frame = bounds
        circle.masksToBounds = true
        
        circle.instanceCount = dotCount
        circle.instanceColor = color.cgColor

        let angle = (Float.pi * 2)/Float(dotCount)
        circle.instanceTransform = CATransform3DMakeRotation(CGFloat(angle), 0.0, 0.0, 1.0)
    }
    
    private func textConfiguration() {
        let size = CGSize(width: const.font.height.tiny, height: const.font.height.tiny)
        
        north.bounds = CGRect(origin: .zero, size: size)
        north.center = CGPoint(x: bounds.midX, y: const.font.height.tiny)
        
        south.bounds = CGRect(origin: .zero, size: size)
        south.center = CGPoint(x: bounds.midX, y: bounds.size.height - const.font.height.tiny)
        
        west.bounds = CGRect(origin: .zero, size: size)
        west.center = CGPoint(x: const.font.height.tiny, y: bounds.midY)

        east.bounds = CGRect(origin: .zero, size: size)
        east.center = CGPoint(x:  bounds.size.width - const.font.height.tiny, y: bounds.midY)
    }

    private func dialConfiguration(measurement: String) {
        dial.frame = bounds

        value.bounds = CGRect(origin: .zero, size: CGSize(width: dial.bounds.width, height: const.font.height.medium))
        value.center = CGPoint(x: dial.bounds.midX, y: dial.bounds.midY - 10)
        value.text = measurement
        
        units.bounds = CGRect(origin: .zero, size: CGSize(width: dial.bounds.width, height: const.font.height.small))
        units.center = CGPoint(x: dial.bounds.midX, y: dial.bounds.midY + 10)
        units.text = "м/с"
    }
    
    private func arrowConfiguration(degrees: Int) {
        let size = CGSize(width: 3, height: bounds.height/4)
        let tipImage = UIImage(systemName: "location.north.fill")?.withTintColor(color).cgImage

        tip.bounds = CGRect(origin: .zero, size: CGSize(width: 17, height: 17))
        tip.position = CGPoint(x: 2, y: 0)
        tip.masksToBounds = true
        tip.contents = tipImage
        tip.borderColor = UIColor.white.cgColor

        arrow.bounds = CGRect(origin: .zero, size: size)
        arrow.position = CGPoint(x: bounds.midX, y: bounds.midY)
        arrow.anchorPoint = center
        
        arrow.masksToBounds = false
        arrow.opacity = 0.8
        arrow.backgroundColor = color.cgColor
        
        arrow.transform = CATransform3DMakeRotation(degrees.degreesToRadians(), 0.0, 0.0, 1.0)
    }
}
