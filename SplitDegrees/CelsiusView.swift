//
//  CelsiusView.swift
//  SplitDegrees
//
//  Created by Matthew Curtner on 9/13/16.
//  Copyright © 2016 Matthew Curtner. All rights reserved.
//

import UIKit

class CelsiusView: UIView {
    
    // Declare Labels
    var celsiusValueLabel = UILabel()
    var celsiusSymbolLabel = UILabel()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /// Initialize the Celsius view for display
    ///
    /// - parameter frame: View's Frame
    ///
    /// - returns: Celsius view
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0.0, y: 0.0, width: frame.size.width/2, height: frame.size.height))
        backgroundColor = initialCelsiusColor
        isUserInteractionEnabled = true
        
        setupLabels()
    }
    
    /// Position the temperature value label and symbol label
    /// based on user interface idiom
    private func setupLabels() {
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            // The device is an iPad
            celsiusValueLabel =  UILabel(frame: CGRect(x: 3, y: self.frame.height/2 - 20, width: self.frame.width - 10, height: 80))
            celsiusSymbolLabel = UILabel(frame: CGRect(x: self.frame.size.width/2 + 115, y: self.frame.height/2 - 60, width: 50, height: 50))
            celsiusSymbolLabel.font = tempSymbolFontIPad
            celsiusValueLabel.font = iPadFont
            
        case .phone:
            iPhoneLblSetup()
        default:
            iPhoneLblSetup()
        }
        
        celsiusSymbolLabel.textColor = textColor
        celsiusSymbolLabel.text = "℃"
        
        celsiusValueLabel.text = defaultCelsius
        celsiusValueLabel.textAlignment = .center
        celsiusValueLabel.textColor = textColor
        celsiusValueLabel.shadowColor = shadowColor
        celsiusValueLabel.shadowOffset = offsetSize
        
        
        self.addSubview(celsiusValueLabel)
        self.addSubview(celsiusSymbolLabel)
    }
    
    
    /// iPhone label size, position, and font setup function
    private func iPhoneLblSetup() {
        // The device is an iPhone or iPod touch.
        celsiusValueLabel = UILabel(frame: CGRect(x: 3.0, y: self.frame.height/2 - 20, width: self.frame.width - 10, height: 70))
        celsiusValueLabel.font = iPhoneFont
        celsiusSymbolLabel = UILabel(frame: CGRect(x: self.frame.size.width/2 + 50, y: self.frame.height/2 - 30, width: 30, height: 30))
        celsiusSymbolLabel.font = tempSymbolFontIPhone
    }
}
