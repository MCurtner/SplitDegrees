//
//  Conversions.swift
//  SplitDegrees
//
//  Created by Matthew Curtner on 9/14/16.
//  Copyright © 2016 Matthew Curtner. All rights reserved.
//

import Foundation

//MARK: - Temperature Conversion Methods

/// Convert Fahrenheit value to Celsius
///
/// - parameter fahrenheit: Fahrenheit Double Value
///
/// - returns: Calculated Fahrenheit Float Value
func convertFahrenheitToCelsius(fahrenheit: Double) -> Double {
    let celsius = (fahrenheit - 32.0) / 1.8000
    return celsius
}

/// Convert Celsius value to Fahrenheit
///
/// - parameter celsius: Celsius Double Value
///
/// - returns: Calculated Celsius Float Value
func convertCelsiusToFahrenheit(celsius: Double) -> Double {
    let fahrenheit = (celsius * 1.800) + 32
    return fahrenheit
}

// MARK: - Conversion Helper Methods
/// Convert String to Float value
///
/// - parameter tempatureLblValue: String
///
/// - returns: Float Value
func convertStringToDouble(tempatureLblValue: String) -> Double {
    return Double(tempatureLblValue)!
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
