//
//  FahrenheitView.swift
//  SplitDegrees
//
//  Created by Matthew Curtner on 9/14/16.
//  Copyright © 2016 Matthew Curtner. All rights reserved.
//

import UIKit

class FahrenheitView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: frame.size.width/2, y: 0.0, width: frame.size.width/2, height: frame.size.height))
        backgroundColor = UIColor(hue: 0.5332, saturation: 1.0, brightness: 1.0, alpha: 1.0)
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
