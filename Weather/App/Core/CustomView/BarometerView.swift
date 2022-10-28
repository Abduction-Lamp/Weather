//
//  BarometerView.swift
//  Weather
//
//  Created by Владимир on 02.06.2022.
//

import UIKit

final class BarometerView: UIView {

    private let font = DesignConstants.shared.font
    
    private let indicatorSize = CGSize(width: 7, height: 20)
    private let color = UIColor.white

    private let dotLeft = CALayer()
    private let dotRight = CALayer()
    private let graduationLeft = CAReplicatorLayer()
    private let graduationRight = CAReplicatorLayer()
    private let indicator = CALayer()
    private let arrow = CALayer()
    
    private lazy var value: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = font.medium
        return label
    }()
    
    private lazy var units: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = font.small
        return label
    }()
    
    private var pressure: Int = 0
    

    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("📛 BarometerView init(coder:) has not been implemented")
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        dotConfigure()
        graduationConfigure(number: 13)
        arrowConfigure(value: pressure)
        displayConfigure()
    }
    
    
    // MARK: Configuration content
    private func buildContent() {
        backgroundColor = .clear
        
        graduationLeft.addSublayer(dotLeft)
        layer.addSublayer(graduationLeft)
        
        graduationRight.addSublayer(dotRight)
        layer.addSublayer(graduationRight)
        
        arrow.addSublayer(indicator)
        layer.addSublayer(arrow)
        
        addSubview(value)
        addSubview(units)
    }
    
    private func dotConfigure() {
        let dotSize = CGSize(width: 3, height: 10)
        
        dotLeft.masksToBounds = true
        dotRight.masksToBounds = true
        
        dotLeft.backgroundColor = color.cgColor
        dotRight.backgroundColor = color.cgColor
        
        dotLeft.cornerRadius = 1
        dotRight.cornerRadius = 1
        
        dotLeft.bounds = CGRect(origin: .zero, size: dotSize)
        dotRight.bounds = CGRect(origin: .zero, size: dotSize)
        
        dotLeft.position = CGPoint(x: bounds.midY, y: indicatorSize.height/2)
        dotRight.position = CGPoint(x: bounds.midY, y: indicatorSize.height/2)
    }
    
    private func graduationConfigure(number dot: Int) {
        let rotationAngle = 135
        let angle: CGFloat = rotationAngle.degreesToRadians()/Double(dot)
        
        graduationLeft.frame = bounds
        graduationRight.frame = bounds
        
        graduationLeft.masksToBounds = true
        graduationRight.masksToBounds = true
        
        graduationLeft.instanceCount = dot
        graduationRight.instanceCount = dot
        
        graduationLeft.instanceColor = color.withAlphaComponent(0.5).cgColor
        graduationRight.instanceColor = color.withAlphaComponent(0.5).cgColor

        graduationLeft.instanceTransform = CATransform3DMakeRotation(-angle, 0.0, 0.0, 1.0)
        graduationRight.instanceTransform = CATransform3DMakeRotation(angle, 0.0, 0.0, 1.0)
    }
    
    private func arrowConfigure(value: Int) {
        let arrowSize = CGSize(width: indicatorSize.width, height: bounds.height)
        
        indicator.masksToBounds = true
        indicator.backgroundColor = color.cgColor
        indicator.cornerRadius = 3
        
        indicator.bounds = CGRect(origin: .zero, size: indicatorSize)
        indicator.position = CGPoint(x: indicatorSize.width/2, y: indicatorSize.height/2)
        
        arrow.masksToBounds = true
        arrow.backgroundColor = UIColor.clear.cgColor
        
        arrow.bounds = CGRect(origin: .zero, size: arrowSize)
        arrow.position = CGPoint(x: bounds.midX, y: bounds.midY)
        
        arrow.transform = CATransform3DMakeRotation(calculationDeviationArrow(pressure: value), 0.0, 0.0, 1.0)
    }
    
    private func displayConfigure() {
        value.bounds = CGRect(origin: .zero, size: CGSize(width: bounds.width, height: font.height.medium))
        value.center = CGPoint(x: bounds.midX, y: bounds.midY - 10)
        
        units.bounds = CGRect(origin: .zero, size: CGSize(width: bounds.width, height: font.height.small))
        units.center = CGPoint(x: bounds.midX, y: bounds.midY + 10)
    }
}


extension BarometerView {
    
    // MARK: - Calculation Deviation Arrow
    ///
    /// normal       = 1013   гПа                           -- нормальное атмосферное давление
    /// min            = 930     гПа                           -- минимальное зафиксированное атмосферное давление
    /// max           = 1070   гПа                           -- максимальное зафиксированное атмосферное давление
    ///
    /// middle       = (min + max) / 2     = 1000    -- середина циферблата барометра (в гПа)
    /// delta          = (max - min) / 2      = 70        -- растояние до максимального или минимального значение от середины
    ///
    /// arc             = 135                                      -- циферблат это дуга в 270 градусов (по 135 градусов от центра влево и вправо соответственно)
    ///
    /// deviation   = middle - pressure                -- отклонение стрелки влево или в право в гПа
    /// angle         = -deviation * arc / delta        -- угол на который отклонилась стрелка в градусах
    ///
    private func calculationDeviationArrow(pressure: Int) -> CGFloat {
        let middle = 1000
        let delta = 70
        let arc = 135
        
        var deviation = middle - pressure
        deviation = deviation > 0 ? min(deviation, delta) : max(deviation, -delta)
        
        let angle = -deviation * arc / delta
        
        return angle.degreesToRadians()
    }
}


extension BarometerView {
    
    public func setup(measurement: String, pressure: Int, units: String) {
        self.value.text = measurement
        self.units.text = units
        self.pressure = pressure
        setNeedsLayout()
    }
}
