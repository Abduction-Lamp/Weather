//
//  AirIndicatorView.swift
//  Weather
//
//  Created by Владимир on 21.10.2022.
//

import UIKit

final class AirIndicatorView: UIView {

    private var aqi: Int = 0
    private var indicator: [CAShapeLayer] = []

    
    // MARK: Initialization
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

        for _ in 1 ..< CAQIEuropeScale.allCases.count {
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
        
        let step = (180 / indicator.count).toRadians()
        
        var start = 180.toRadians()
        var end = start + step
        
        if indicator.count == (CAQIEuropeScale.allCases.count - 1) {
            for index in 0 ..< indicator.count {
                let path = UIBezierPath()
                path.addArc(withCenter: center, radius: bigRadius, startAngle: start, endAngle: end, clockwise: true)
                
                if CAQIEuropeScale.allCases[index].rawValue == aqi {
                    path.addLine(to: center)
                } else {
                    path.addArc(withCenter: center, radius: smallRadius, startAngle: end, endAngle: start, clockwise: false)
                }
                path.close()
                
                indicator[index].path = path.cgPath
                indicator[index].fillColor = CAQIEuropeScale.allCases[index].color.cgColor
                indicator[index].opacity = 1
                
                start = end
                end += step
            }
        }
    }
}


extension AirIndicatorView {
    
    public func setup(aqi: Int) {
        if CAQIEuropeScale.allCases.contains(where: { $0.rawValue == aqi }) {
            self.aqi = aqi
            setNeedsLayout()
        }
    }
}
