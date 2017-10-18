//
//  FloodAnnotation.swift
//  HighWaters
//
//  Created by Mohammad Azam on 10/12/17.
//  Copyright © 2017 Mohammad Azam. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import MapKit

class FloodAnnotation : MKPointAnnotation {
    
    var flood :Flood
    
    init(flood :Flood) {
        
        self.flood = flood
        super.init()
        self.coordinate = flood.coordinate
        self.title = "Reported on \(flood.reportedAt)"
    }
    
}
