//
//  TempController.swift
//  SplitDegrees
//
//  Created by Matthew Curtner on 8/16/18.
//  Copyright © 2018 Matthew Curtner. All rights reserved.
//

import UIKit

class TempController {
    
    //MARK: - Temperature Conversion Methods
    
    /// Convert Fahrenheit  to Celsius
    ///
    /// - parameter fahrenheit: Fahrenheit Double Value
    ///
    /// - returns: Calculated Fahrenheit Float Value
    func convertFahrenheitToCelsius(fahrenheit: Double) -> Double {
        let celsius = (fahrenheit - 32.0) / 1.8000
        return celsius
    }
    
    /// Convert Celsius  to Fahrenheit
    ///
    /// - parameter celsius: Celsius Double Value
    ///
    /// - returns: Calculated Celsius Float Value
    func convertCelsiusToFahrenheit(celsius: Double) -> Double {
        let fahrenheit = (celsius * 1.800) + 32
        return fahrenheit
    }
    
    /// Format the provided double value and convert to string
    ///
    /// - parameter total: Double
    ///
    /// - returns: String
    func convertToStringFormattedValue(total: Double) -> String {
        // Convert Double to NSNumber
        let myNumber = NSNumber(value: Double(total))
        
        // Set format styling
        let fmt = NumberFormatter()
        fmt.numberStyle = .decimal
        fmt.maximumFractionDigits = 1
        
        // Ensure the number will be in US locale
        fmt.locale = Locale(identifier: "en_US_POSIX")
        
        // Convert Formatted Number to String
        let str = fmt.string(from: myNumber)!
        
        return "\(str)"
    }

    func celsiusColor(temperature: CGFloat) -> UIColor {
        var num = (-temperature + 97) / 255.0
        
        //
        if temperature >= 105.0 {
            num = (-105 + 97) / 255.0
            return UIColor(hue: num + num, saturation: 1.0, brightness: 0.98, alpha: 1.0)
        }
        
        //
        if temperature <= 18.0 {
            num = 0.3098//(-14 + 95) / 255.0 d
            return UIColor(hue: num + num, saturation: 1.0, brightness: 0.98, alpha: 1.0)
        } else {
            return UIColor(hue: num + num, saturation: 1.0, brightness: 0.98, alpha: 1.0)
        }
    }
    
    func fahrenheitColor(temperature: CGFloat) -> UIColor {
        var num = (-temperature + 100) / 255.0
        
        if temperature >= 100.0 {
            num = -0.01176//(-109 + 100) / 255.0
            return UIColor(hue: num + num, saturation: 1.0, brightness: 1.0, alpha: 1.0)
        }
        
        if temperature <= 13.0 {
            num = (-13.0 + 100) / 255.0
            return UIColor(hue: num + num, saturation: 1.0, brightness: 1.0, alpha: 1.0)
        } else {
            return UIColor(hue: num + num, saturation: 1.0, brightness: 1.0, alpha: 1.0)
        }
    }
}
