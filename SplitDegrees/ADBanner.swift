//
//  ADBanner.swift
//  SplitDegrees
//
//  Created by Matthew Curtner on 9/14/16.
//  Copyright © 2016 Matthew Curtner. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ADBanner: GADBannerView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        //super.init(frame: CGRect(x: 0, y: frame.size.height - 50, width: frame.size.width, height: 50))
        super.init(frame: CGRect(x: 0, y: frame.size.height, width: frame.size.width, height: 50))
        isUserInteractionEnabled = true
        self.backgroundColor = .red
    }
    
    public func displayAd(showAds: Bool) {
        let request = GADRequest()
        
        if showAds {
            request.testDevices = [kGADSimulatorID]
            //self.adUnitID = "ca-app-pub-9801328113033460~4899849037"
            self.adUnitID = "ca-app-pub-3940256099942544/2934735716"
            self.load(request)
        } else {
            self.load(nil)
            self.isHidden = true
        }
    }
}
