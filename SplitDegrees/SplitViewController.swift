//
//  SplitViewController.swift
//  SplitDegrees
//
//  Created by Matthew Curtner on 9/13/16.
//  Copyright © 2016 Matthew Curtner. All rights reserved.
//

import UIKit
import GoogleMobileAds

class SplitViewController: UIViewController {
    
    // Declare Variables
    var celsiusView: TemperatureView!
    var fahrenheitView: TemperatureView!
    var tempController = TempController()
    
    var clearLabel = UILabel()
    
    var adVisible: Bool = false
    var isClearLabelVisible: Bool = false
    
    lazy var adBannerView: GADBannerView = {
        let adBannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        adBannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716" //"ca-app-pub-9801328113033460/6376582230"
        adBannerView.delegate = self
        adBannerView.rootViewController = self
        adBannerView.load(GADRequest())
        
        return adBannerView
    }()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupCelsiusView()
        setupFahrenheitView()
        loadAd()
    }
    
    /// Set Status Bar Style to light
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    ///  Add the adBannerView to the view
    func loadAd() {
        view.addSubview(adBannerView)
    }
    
    private func setupView(frame: CGRect, backgroundColor: UIColor, temperatureValue: String, symbol: String) -> TemperatureView {
        let view = TemperatureView(frame: frame)
        view.backgroundColor = backgroundColor
        view.temperatureLabel.text = temperatureValue
        view.symbolLabel.text = symbol
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(calcTemp))
        view.addGestureRecognizer(panGesture)
        
        return view
    }
    
    func setupCelsiusView() {
        // Add Celsius View and pan gesture
        celsiusView = setupView(frame: CGRect(x: 0.0,
                                              y: 0.0,
                                              width: self.view.frame.size.width / 2,
                                              height: self.view.frame.size.height),
                                backgroundColor: initialCelsiusColor,
                                temperatureValue: defaultCelsius,
                                symbol: celsiusSymbol)
        
        view.addSubview(celsiusView)
    }
    
    func setupFahrenheitView() {
        // Add Fahrenheit View and pan gesture
        fahrenheitView = setupView(frame: CGRect(x: self.view.frame.size.width / 2,
                                                 y: 0.0,
                                                 width: self.view.frame.size.width / 2,
                                                 height: self.view.frame.size.height),
                                   backgroundColor: initialFahrenheitColor,
                                   temperatureValue: defaultFahrenheit,
                                   symbol: fahrenheitSymbol)

        view.addSubview(fahrenheitView)
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
    
    // MARK: - Shake Gesture Recognizer
    /// Allow the VC to be the first responder
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    /// After shaking has ended, set the views inital values
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            fahrenheitView.temperatureLabel.text = defaultFahrenheit
            celsiusView.temperatureLabel.text = defaultCelsius
            
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
    @objc func calcTemp(recognizer: UIPanGestureRecognizer) {
        let translation: CGPoint = recognizer.translation(in: recognizer.view)
        
        if (translation.y < -20 || translation.y > 20) {
            let sign: Int = translation.y > 0 ? -1 : 1
            
            recognizer.setTranslation(CGPoint(x: 0, y: 0), in: self.view)
            
            
            if recognizer.view == celsiusView {
                var currentCelsiusValue = celsiusView.temperatureLabel.text!.doubleValue

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
                fahrenheitView.backgroundColor = TempController().fahrenheitColor(temperature: 32.0 + (CGFloat(increasedValue) * 1.800))
                celsiusView.backgroundColor = TempController().celsiusColor(temperature: 32.0 + (CGFloat(increasedValue) * 1.800))

                //Display Celsius value
                celsiusView.temperatureLabel.text = tempController.convertToStringFormattedValue(total: increasedValue)

                //Convert Celsius to Fahrenheit
                let fahrenheitValue = tempController.convertCelsiusToFahrenheit(celsius: celsiusView.temperatureLabel.text!.doubleValue)

                //Display Fahrenheit value
                fahrenheitView.temperatureLabel.text = tempController.convertToStringFormattedValue(total: fahrenheitValue)

            } else {
                //Convert text to double
                var currentFahrValue = fahrenheitView.temperatureLabel.text!.doubleValue

                //Round the Value
                currentFahrValue = round(currentFahrValue)

                //Add one to value and
                let increasedValue = (currentFahrValue + Double(sign * 1))
                //print(increasedValue)

                // Display 'Shake to Reset' label
                if increasedValue > 32 || increasedValue < 32 {
                    if isClearLabelVisible == false {
                        displayClearLabel()
                        isClearLabelVisible = true
                    }
                }

                //Update the View's background colors
                fahrenheitView.backgroundColor = tempController.fahrenheitColor(temperature: CGFloat(increasedValue))
                celsiusView.backgroundColor = tempController.celsiusColor(temperature: CGFloat(increasedValue))

                //Display Fahrenheit value
                fahrenheitView.temperatureLabel.text = tempController.convertToStringFormattedValue(total: increasedValue)

                //Convert Fahrenheit to Celsius
                let celsiusValue = tempController.convertFahrenheitToCelsius(fahrenheit: fahrenheitView.temperatureLabel.text!.doubleValue)

                //Display celsius value
                celsiusView.temperatureLabel.text = tempController.convertToStringFormattedValue(total: celsiusValue)
            }
        }
    }

}

// MARK: - GADBannerView Delegate Methods
extension SplitViewController: GADBannerViewDelegate {
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        if !adVisible {
            UIView.animate(withDuration: 0.25, animations: {
                
                self.addBannerViewToView(self.adBannerView)
                self.adBannerView.frame.origin.y -= self.adBannerView.frame.size.height
            }) { (bool) in
                self.adVisible = true
            }
        }
    }
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        print("MCU: Error in loading ad: \(error)")
        if adVisible {
            UIView.animate(withDuration: 0.25, animations: {
                self.adBannerView.frame.origin.y += self.adBannerView.frame.size.height
            }) { (bool) in
                self.adVisible = false
            }
        }
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        if #available(iOS 11.0, *) {
            // In iOS 11, we need to constrain the view to the safe area.
            positionBannerViewFullWidthAtBottomOfSafeArea(bannerView)
        }
        else {
            // In lower iOS versions, safe area is not available so we use
            // bottom layout guide and view edges.
            positionBannerViewFullWidthAtBottomOfView(bannerView)
        }
    }
    
    // MARK: - view positioning
    @available (iOS 11, *)
    func positionBannerViewFullWidthAtBottomOfSafeArea(_ bannerView: UIView) {
        // Position the banner. Stick it to the bottom of the Safe Area.
        // Make it constrained to the edges of the safe area.
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            guide.leftAnchor.constraint(equalTo: bannerView.leftAnchor),
            guide.rightAnchor.constraint(equalTo: bannerView.rightAnchor),
            guide.bottomAnchor.constraint(equalTo: bannerView.bottomAnchor)
            ])
    }
    
    func positionBannerViewFullWidthAtBottomOfView(_ bannerView: UIView) {
        view.addConstraint(NSLayoutConstraint(item: bannerView,
                                              attribute: .leading,
                                              relatedBy: .equal,
                                              toItem: view,
                                              attribute: .leading,
                                              multiplier: 1,
                                              constant: 0))
        view.addConstraint(NSLayoutConstraint(item: bannerView,
                                              attribute: .trailing,
                                              relatedBy: .equal,
                                              toItem: view,
                                              attribute: .trailing,
                                              multiplier: 1,
                                              constant: 0))
        view.addConstraint(NSLayoutConstraint(item: bannerView,
                                              attribute: .bottom,
                                              relatedBy: .equal,
                                              toItem: bottomLayoutGuide,
                                              attribute: .top,
                                              multiplier: 1,
                                              constant: 0))
    }
}
