//
//  ItemAirComponentView.swift
//  Weather
//
//  Created by Владимир on 26.10.2022.
//

import UIKit

final class ItemAirComponentView: UIView {
    
    private var name: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.font = DesignConstants.shared.font.small
        return label
    }()

    private var designation: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = DesignConstants.shared.font.small
        return label
    }()
    
    private var value: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = .white
        label.font = DesignConstants.shared.font.small
        return label
    }()
    
    
    // MARK: Initialization
    //
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("📛 ItemAirComponentView init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentConfiguration()
    }
}


extension ItemAirComponentView {
    
    private func buildContent() {
        layer.cornerRadius = 10
        
        addSubview(name)
        addSubview(designation)
        addSubview(value)
    }
    
    private func contentConfiguration() {
        var origin: CGPoint = .zero
        var size: CGSize = CGSize(width: bounds.width / 2, height: bounds.height)
        name.frame = CGRect(origin: origin, size: size)
        
        origin.x = name.frame.maxX
        size.width = bounds.width / 4 - DesignConstants.shared.padding.small
        designation.frame = CGRect(origin: origin, size: size)
        
        origin.x = designation.frame.maxX
        size.width = bounds.width / 4
        value.frame = CGRect(origin: origin, size: size)
    }
    
    
    public func setup(name: String, designation: String, value: String, color: UIColor = .clear) {
        backgroundColor = (color == .clear) ? color : color.withAlphaComponent(0.9)
        self.name.text = name
        self.designation.text = designation
        self.value.text = value
    }
}
