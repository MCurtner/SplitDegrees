//
//  SplitViewController.swift
//  SplitDegrees
//
//  Created by Matthew Curtner on 9/13/16.
//  Copyright © 2016 Matthew Curtner. All rights reserved.
//

import UIKit
import GoogleMobileAds

class SplitViewController: UIViewController, GADBannerViewDelegate {
    
    // Declare Variables
    var showAds: Bool = true
    var adVisible: Bool = false
    
    var celsiusView: CelsiusView!
    var fahrenheitView: FahrenheitView!
    var banner: ADBanner!
    
    var clearLabel = UILabel()
    var isClearLabelVisible: Bool = false
    
    var infoButton: UIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add Celsius View and pan gesture
        celsiusView = CelsiusView(frame: self.view.frame)
        let panCelsiusUp = UIPanGestureRecognizer(target: self, action: #selector(setCelsiusTemp))
        celsiusView.addGestureRecognizer(panCelsiusUp)
        view.addSubview(celsiusView)
        
        // Add Fahrenheit View and pan gesture
        fahrenheitView = FahrenheitView(frame: self.view.frame)
        let panFahrenheitUp = UIPanGestureRecognizer(target: self, action: #selector(setFahrenheitTemp))
        fahrenheitView.addGestureRecognizer(panFahrenheitUp)
        view.addSubview(fahrenheitView)
        
        // Display Ad Banner
        banner = ADBanner(frame: self.view.frame)
        banner.delegate = self
        banner.rootViewController = self
        banner.displayAd(showAds: showAds)
        view.addSubview(banner!)

    }
    
    /// Set Status Bar Style to light
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
   
    /// Create 'Shake to Reset' label with animation of fading in
    func displayClearLabel() {
        clearLabel = UILabel(frame: CGRect(x: 2.0, y: 30.0, width: self.view.frame.size.width, height: 60.0))
        clearLabel.text = "Shake To Reset"
        clearLabel.textAlignment = .center
        clearLabel.font = UIFont(name: fontName, size: 20)
        clearLabel.textColor = textColor
        clearLabel.shadowColor = shadowColor
        clearLabel.shadowOffset =  CGSize(width: 1, height: 2)
        view.addSubview(clearLabel)
        
        UIView.animate(withDuration: 2.0, animations: { () -> Void in
            self.clearLabel.alpha = 0
            self.clearLabel.alpha = 1
        })
    }
    
    // MARK: - GADBannerView Delegate Methods
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        if !adVisible {
            UIView.animate(withDuration: 0.25, animations: {
                self.banner.frame.origin.y -= 50
            }) { (bool) in
                self.adVisible = true
            }
        }
    }
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        if adVisible {
            UIView.animate(withDuration: 0.25, animations: {
                self.banner.frame.origin.y += 50
            }) { (bool) in
                self.adVisible = false
            }
        }
    }
    

    // MARK: - Shake Gesture Recognizer
    /// Allow the VC to be the first responder
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    /// After shaking has ended, set the views inital values
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            fahrenheitView.fahrenheitValueLabel.text = defaultFahrenheit
            celsiusView.celsiusValueLabel.text = defaultCelsius
            setInitialBackgroundColors()
            
            if isClearLabelVisible == true {
                animateClearLabelFadeOut()
                isClearLabelVisible = false
            }
        }
    }
    
    /// Animate the clear label to fade out
    func animateClearLabelFadeOut() {
        UIView.animate(withDuration: 2.0, animations: { () -> Void in
            self.clearLabel.alpha = 1
            self.clearLabel.alpha = 0
        })
    }
    
    /// Set the UIView's background color to the initial 
    /// background color
    func setInitialBackgroundColors() {
        fahrenheitView.backgroundColor = initialFahrenheitColor
        celsiusView.backgroundColor = initialCelsiusColor
    }
    
    // MARK: - Calculate View Temperature Changes
    
    @objc func setFahrenheitTemp(recognizer:UIPanGestureRecognizer) {
        // Store the point of the pan gesture
        let translation: CGPoint = recognizer.translation(in: recognizer.view!)
    
        if (translation.y < -20 || translation.y > 20) {
            let sign: Int = translation.y > 0 ? -1 : 1
            
            recognizer.setTranslation(CGPoint(x: 0, y: 0), in: self.view)
            
            //Convert text to double
            var currentFahrValue = convertStringToDouble(tempatureLblValue: fahrenheitView.fahrenheitValueLabel.text!)
            
            //Round the Value
            currentFahrValue = round(currentFahrValue)
        
            //Add one to value and
            let increasedValue = (currentFahrValue + Double(sign * 1))
            print(increasedValue)
            
            // Display 'Shake to Reset' label
            if increasedValue > 32 || increasedValue < 32 {
                if isClearLabelVisible == false {
                    displayClearLabel()
                    isClearLabelVisible = true
                }
            }
            
            //Update the View's background colors
            fahrenheitView.backgroundColor = setFahrenTempBackgroundColor(temperature: CGFloat(increasedValue))
            celsiusView.backgroundColor = setCelsiusTempBackgroundColor(temperature: CGFloat(increasedValue))
            
            //Display Fahrenheit value
            fahrenheitView.fahrenheitValueLabel.text = convertToStringFormattedValue(total: increasedValue)

            //Convert Fahrenheit to Celsius
            let celsiusValue = convertFahrenheitToCelsius(fahrenheit: convertStringToDouble(tempatureLblValue: fahrenheitView.fahrenheitValueLabel.text!))

            //Display celsius value
            celsiusView.celsiusValueLabel.text = convertToStringFormattedValue(total: celsiusValue)
        }
    }

    @objc func setCelsiusTemp(recognizer:UIPanGestureRecognizer) {
        let translation: CGPoint = recognizer.translation(in: recognizer.view!)

        if (translation.y < -20 || translation.y > 20) {
            let sign: Int = translation.y > 0 ? -1 : 1
            
            recognizer.setTranslation(CGPoint(x: 0, y: 0), in: self.view)
            
            //Convert text to double
            var currentCelsiusValue = convertStringToDouble(tempatureLblValue: celsiusView.celsiusValueLabel.text!)
            
            //Round the value
            currentCelsiusValue = round(currentCelsiusValue)
            
            //Add one to value and
            let increasedValue = (currentCelsiusValue + Double(sign * 1))
            
            // Display 'Shake to Reset' label
            if increasedValue > 0 || increasedValue < 0 {
                if isClearLabelVisible == false {
                    displayClearLabel()
                    isClearLabelVisible = true
                }
            }
            
            //Update UIView background color
            fahrenheitView.backgroundColor = setFahrenTempBackgroundColor(temperature: 32.0 + (CGFloat(increasedValue) * 1.800))
            celsiusView.backgroundColor = setCelsiusTempBackgroundColor(temperature: 32.0 + (CGFloat(increasedValue) * 1.800))
            
            //Display Celsius value
            celsiusView.celsiusValueLabel.text = convertToStringFormattedValue(total: increasedValue)
            
            //Convert Celsius to Fahrenheit
            let fahrenheitValue = convertCelsiusToFahrenheit(celsius: convertStringToDouble(tempatureLblValue: celsiusView.celsiusValueLabel.text!))
            
            //Display Fahrenheit value
            fahrenheitView.fahrenheitValueLabel.text = convertToStringFormattedValue(total: fahrenheitValue)
        }
    }
    
    // MARK: - Change UIView Background Color
    
    func setFahrenTempBackgroundColor(temperature: CGFloat) -> UIColor {
        var num = (-temperature + 100) / 255.0
        
        if temperature >= 95.0 {
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
    
    func setCelsiusTempBackgroundColor(temperature: CGFloat) -> UIColor {
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
}
