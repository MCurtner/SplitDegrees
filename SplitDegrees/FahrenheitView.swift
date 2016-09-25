//
//  FahrenheitView.swift
//  SplitDegrees
//
//  Created by Matthew Curtner on 9/14/16.
//  Copyright © 2016 Matthew Curtner. All rights reserved.
//

import UIKit

class FahrenheitView: UIView {
    
    // Declare Labels
    var fahrenheitValueLabel = UILabel()
    var fahrenheitSymbolLabel = UILabel()
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /// Initialize the Fahrenheit view for display
    ///
    /// - parameter frame: View's Frame
    ///
    /// - returns: Fahrenheit view
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: frame.size.width/2, y: 0.0, width: frame.size.width/2, height: frame.size.height))
        backgroundColor = initialFahrenheitColor
        isUserInteractionEnabled = true
        
        setupLabels()
    }
    
    /// Position the temperature value label and symbol label
    /// based on user interface idiom
    private func setupLabels() {
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            print("it is an iPad")
            // The device is an iPad
            fahrenheitValueLabel = UILabel(frame: CGRect(x: 3.0, y: self.frame.height/2 - 20, width: self.frame.width - 10, height: 80))
            fahrenheitSymbolLabel = UILabel(frame: CGRect(x: self.frame.size.width/2 + 115, y: self.frame.height/2 - 60, width: 50, height: 50))
            fahrenheitSymbolLabel.font = tempSymbolFontIPad
            fahrenheitValueLabel.font = iPadFont

        case .phone:
            iPhoneLblSetup()
            
        default:
            iPhoneLblSetup()
        }

        fahrenheitSymbolLabel.textColor = textColor
        fahrenheitSymbolLabel.text = "℉"
        fahrenheitValueLabel.shadowColor = shadowColor
        fahrenheitValueLabel.shadowOffset = offsetSize
        
        fahrenheitValueLabel.text = defaultFahrenheit
        fahrenheitValueLabel.textAlignment = .center
        fahrenheitValueLabel.textColor = textColor
        
        self.addSubview(fahrenheitValueLabel)
        self.addSubview(fahrenheitSymbolLabel)
    }
    

    /// iPhone label size, position, and font setup function
    private func iPhoneLblSetup() {
        // The device is an iPhone or iPod touch.
        fahrenheitValueLabel = UILabel(frame: CGRect(x: 3.0, y: self.frame.height/2 - 20, width: self.frame.width - 10, height: 70))
        fahrenheitValueLabel.font = iPhoneFont
        fahrenheitSymbolLabel = UILabel(frame: CGRect(x: self.frame.size.width/2 + 50, y: self.frame.height/2 - 30, width: 30, height: 30))
        fahrenheitSymbolLabel.font = tempSymbolFontIPhone
    }
    
}
