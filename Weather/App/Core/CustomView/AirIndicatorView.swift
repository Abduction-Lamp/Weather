//
//  AirIndicatorView.swift
//  Weather
//
//  Created by Владимир on 21.10.2022.
//

import UIKit

final class AirIndicatorView: UIView {
    
    /// 1, Good, Green
    /// 2, Fair, Yellow
    /// 3, Moderate, Orange
    /// 4, Poor, Red
    /// 5, Very Poor, Vinous / Purple
    private let segmentInfo: [(index: Int, name: String, color: UIColor)] = [
        (index: 1, name: "", color: .systemGreen),
        (index: 2, name: "", color: .systemYellow),
        (index: 3, name: "", color: .systemOrange),
        (index: 4, name: "", color: .systemRed),
        (index: 5, name: "", color: .systemPurple)
    ]

    private var indicator: [CAShapeLayer] = []
    
    // Air quality index
    private var aqi: Int = 0
    
    
    
    // MARK: Initialization
    //
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        buildContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("📛 AirIndicatorView init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        segmentConfiguration()
    }
    
    
    private func buildContent() {
        backgroundColor = .clear
        
        segmentInfo.forEach { _ in
            indicator.append(CAShapeLayer())
        }
        indicator.forEach { segment in
            layer.addSublayer(segment)
        }
    }
    
    private func segmentConfiguration() {
        let width: CGFloat = 20
        
        let bigRadius = bounds.width / 2
        let smallRadius = bigRadius - width
        let center = CGPoint(x: bounds.midX, y: bounds.maxY)
        
        let step = (180 / indicator.count).degreesToRadians()
        var start = 180.degreesToRadians()
        var end = start + step
        

        if segmentInfo.count == indicator.count {
            for index in 0 ..< indicator.count {
                let path = UIBezierPath()
                path.addArc(withCenter: center, radius: bigRadius, startAngle: start, endAngle: end, clockwise: true)
                
                if segmentInfo[index].index == aqi {
                    path.addLine(to: center)
                    path.close()
                    
                    indicator[index].path = path.cgPath
                    indicator[index].fillColor = segmentInfo[index].color.cgColor
                    indicator[index].opacity = 1
                } else {
                    path.addArc(withCenter: center, radius: smallRadius, startAngle: end, endAngle: start, clockwise: false)
                    path.close()
                    
                    indicator[index].path = path.cgPath
                    indicator[index].fillColor = segmentInfo[index].color.cgColor
                    indicator[index].opacity = 0.4
                }
                
                start = end
                end += step
            }
        }
    }
}


extension AirIndicatorView {
    
    public func setup(aqi: Int) {
        
        if segmentInfo.contains(where: { $0.index == aqi }) {
            self.aqi = aqi
            setNeedsLayout()
        }
    }
}
