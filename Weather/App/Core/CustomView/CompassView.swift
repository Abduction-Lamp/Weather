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
        label.textColor = .white.withAlphaComponent(0.5)
        label.font = .boldSystemFont(ofSize: UIFont.labelFontSize)
        label.text = NSLocalizedString("CompassView.North", comment: "N")
        return label
    }()
    
    private let south: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white.withAlphaComponent(0.5)
        label.font = .boldSystemFont(ofSize: UIFont.labelFontSize)
        label.text = NSLocalizedString("CompassView.South", comment: "S")
        return label
    }()
    
    private let west: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white.withAlphaComponent(0.5)
        label.font = .boldSystemFont(ofSize: UIFont.labelFontSize)
        label.text = NSLocalizedString("CompassView.Western", comment: "W")
        return label
    }()
    
    private let east: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white.withAlphaComponent(0.5)
        label.font = .boldSystemFont(ofSize: UIFont.labelFontSize)
        label.text = NSLocalizedString("CompassView.East", comment: "E")
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
    
    private let bodyArrow = CALayer()
    private let tipArrow = CAShapeLayer()
    private let endArrow = CAShapeLayer()
        
    private var color = UIColor.white
    
    private var measurement: String = "0"
    private var degrees: Int = 0
    private var unitsMeasurement: String = NSLocalizedString("Units.Speed.ms", comment: "m/s")
    

    // MARK: Initialization
    //
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
        
        arrowConfiguration(degrees: degrees)
        dialConfiguration()
    }
    
    
    // MARK: Configuration content
    //
    private func buildContent() {
        backgroundColor = .clear

        circle.addSublayer(dot)
        layer.addSublayer(circle)
        
        graduation.addSublayer(level)
        layer.addSublayer(graduation)
                
        addSubview(north)
        addSubview(south)
        addSubview(west)
        addSubview(east)
        
        bodyArrow.addSublayer(tipArrow)
        bodyArrow.addSublayer(endArrow)
        
        dial.layer.addSublayer(bodyArrow)
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

        let angle: CGFloat = (360.degreesToRadians())/Double(dotCount)
        graduation.instanceTransform = CATransform3DMakeRotation(angle, 0.0, 0.0, 1.0)
    }

    private func circleConfiguration(dotCount: Int) {
        circle.frame = bounds
        circle.masksToBounds = true
        
        circle.instanceCount = dotCount
        circle.instanceColor = color.cgColor

        let angle: CGFloat = (360.degreesToRadians())/Double(dotCount)
        circle.instanceTransform = CATransform3DMakeRotation(angle, 0.0, 0.0, 1.0)
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

    private func dialConfiguration() {
        dial.frame = bounds

        value.bounds = CGRect(origin: .zero, size: CGSize(width: dial.bounds.width, height: const.font.height.medium))
        value.center = CGPoint(x: dial.bounds.midX, y: dial.bounds.midY - 10)
        value.text = measurement
        
        units.bounds = CGRect(origin: .zero, size: CGSize(width: dial.bounds.width, height: const.font.height.small))
        units.center = CGPoint(x: dial.bounds.midX, y: dial.bounds.midY + 10)
        units.text = unitsMeasurement
    }
    
    private func arrowConfiguration(degrees: Int) {
        let size = CGSize(width: 3, height: dial.bounds.height)
        
        bodyArrow.bounds = CGRect(origin: .zero, size: size)
        bodyArrow.position = CGPoint(x: dial.bounds.midX, y: dial.bounds.midY)
        bodyArrow.masksToBounds = false
        bodyArrow.opacity = 1.0
        bodyArrow.backgroundColor = UIColor.clear.cgColor
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: -5, y: 20))
        path.addLine(to: CGPoint(x: 0, y: 17))
        path.addLine(to: CGPoint(x: 0, y: dial.bounds.height/4))
        path.addLine(to: CGPoint(x: 3, y: dial.bounds.height/4))
        path.addLine(to: CGPoint(x: 3, y: 17))
        path.addLine(to: CGPoint(x: 8, y: 20))
        path.addLine(to: CGPoint(x: 2, y: 0))
        path.addLine(to: CGPoint(x: -5, y: 20))
        
        path.move(to: CGPoint(x: 0, y: 3/4 * dial.bounds.height))
        path.addLine(to: CGPoint(x: 0, y: dial.bounds.height - const.padding.small.top - 10))
        path.addLine(to: CGPoint(x: 3, y: dial.bounds.height - const.padding.small.top - 10))
        path.addLine(to: CGPoint(x: 3, y: 3/4 * dial.bounds.height))
        path.addLine(to: CGPoint(x: 0, y: 3/4 * dial.bounds.height))
        path.close()

        tipArrow.path = path.cgPath
        tipArrow.strokeColor = color.cgColor
        tipArrow.fillColor = color.cgColor
        tipArrow.lineWidth = 1
        
        let oval = UIBezierPath(ovalIn: CGRect(x: -5,
                                               y: dial.bounds.height - const.padding.small.top - 10,
                                               width: 13,
                                               height: 13))
        endArrow.path = oval.cgPath
        endArrow.strokeColor = color.cgColor
        endArrow.fillColor = UIColor.clear.cgColor
        endArrow.lineWidth = 3

        let legal = degrees - 180
        bodyArrow.transform = CATransform3DMakeRotation(legal.degreesToRadians(), 0.0, 0.0, 1.0)
    }
    
    
    public func setup(measurement: String, degrees: Int, units: String) {
        self.measurement = measurement
        self.degrees = degrees
        self.unitsMeasurement = units
        setNeedsLayout()
    }
}
