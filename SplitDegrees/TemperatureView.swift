//
//  TemperatureView.swift
//  SplitDegrees
//
//  Created by Matthew Curtner on 5/15/20.
//  Copyright © 2020 Matthew Curtner. All rights reserved.
//

import UIKit

class TemperatureView: UIView {
    
    var temperatureLabel: UILabel!
    var symbolLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUserIdiom()
        setupView(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupUserIdiom() {
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            setupIPadLabels()
        case .phone:
            setupIPhoneLabels()
        default:
            setupIPhoneLabels()
        }
    }
    
    private func setupView(frame: CGRect) {
        let view = UIView(frame: frame)
        view.isUserInteractionEnabled = true
        
        self.addSubview(view)
    }
    
    func setupLabel(label: UILabel, font: UIFont) {
        label.font = font
        label.textColor = textColor
        label.shadowColor = shadowColor
        label.shadowOffset = offsetSize
        label.textAlignment = .center
        label.textColor = textColor
        
        self.addSubview(label)
    }
    
    private func setupIPadLabels() {
        temperatureLabel = UILabel(frame: CGRect(x: 3.0, y: self.frame.height / 2 - 20, width: self.frame.width - 10, height: 80))
        symbolLabel = UILabel(frame: CGRect(x: self.frame.size.width / 2 + 115, y: self.frame.height / 2 - 60, width: 50, height: 50))
        setupLabel(label: temperatureLabel, font: iPadFont)
        setupLabel(label: symbolLabel, font: tempSymbolFontIPad)
    }
    
    private func setupIPhoneLabels() {
        temperatureLabel = UILabel(frame: CGRect(x: 3.0, y: self.frame.height/2 - 20, width: self.frame.width - 10, height: 70))
        symbolLabel = UILabel(frame: CGRect(x: self.frame.size.width / 2 + 50, y: self.frame.height / 2 - 30, width: 30, height: 30))
        setupLabel(label: temperatureLabel, font: iPhoneFont)
        setupLabel(label: symbolLabel, font: tempSymbolFontIPhone)
    }
}
