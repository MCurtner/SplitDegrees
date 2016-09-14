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
    
    @IBOutlet weak var bannerView: GADBannerView!
    
    var showAds: Bool = true
    
    var celsiusView: CelsiusView!
    var fahrenheitView: FahrenheitView!
    var banner: ADBanner!
    var clearLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let celsiusView = CelsiusView(frame: self.view.frame)
        view.addSubview(celsiusView)
        
        let fahrenheitView = FahrenheitView(frame: self.view.frame)
        view.addSubview(fahrenheitView)
    
        banner = ADBanner(frame: self.view.frame)
        banner.delegate = self
        banner.rootViewController = self
        banner.displayAd(showAds: showAds)
        view.addSubview(banner!)
        
        displayClearLabel()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
   
    func displayClearLabel() {
        clearLabel = UILabel(frame: CGRect(x: 2.0, y: 30.0, width: self.view.frame.size.width, height: 60.0))
        clearLabel.text = "Shake To Reset"
        clearLabel.textAlignment = .center
        clearLabel.font = UIFont(name: fontName, size: 20)
        clearLabel.textColor = UIColor.white
        clearLabel.shadowColor = shadowColor
        clearLabel.shadowOffset =  CGSize(width: 1, height: 2)
        view.addSubview(clearLabel)
        
        UIView.animate(withDuration: 2.0, animations: { () -> Void in
            self.clearLabel.alpha = 0
            self.clearLabel.alpha = 1
        })
    }
}
