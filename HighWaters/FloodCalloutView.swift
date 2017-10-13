//
//  FloodCalloutView.swift
//  HighWaters
//
//  Created by Mohammad Azam on 10/12/17.
//  Copyright © 2017 Mohammad Azam. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class FloodCalloutView : UIView {
    
    @IBOutlet weak var reportAtLabel :UILabel!
    var flood :Flood!
    
    init(frame :CGRect, flood: Flood) {
        super.init(frame: frame)
        
        self.flood = flood
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.backgroundColor = UIColor(fromHexString: "f39c12")
        self.layer.cornerRadius = 10.0
        self.layer.masksToBounds = true
    }
    
}
