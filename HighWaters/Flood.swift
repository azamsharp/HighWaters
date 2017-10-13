//
//  Flood.swift
//  HighWaters
//
//  Created by Mohammad Azam on 10/11/17.
//  Copyright © 2017 Mohammad Azam. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import CoreLocation

struct Flood {
    
    var coordinate :CLLocationCoordinate2D
    var reportedAt :String
    
    func toDictionary() -> [String:Any] {
        
        return ["latitude":self.coordinate.latitude,"longitude":self.coordinate.longitude,
                "reportedAt":self.reportedAt
        ]
    }
}

extension Flood {
    
    init?(snapshot :DataSnapshot) {
        
        guard let snapshotDictionary = snapshot.value as? [String:Any] else {
            return nil
        }
        
        guard let latitude = snapshotDictionary["latitude"] as? Double,
        let longitude = snapshotDictionary["longitude"] as? Double,
        let reportedAt = snapshotDictionary["reportedAt"] as? String
        else {
            return nil
        }
        
        self.reportedAt = reportedAt 
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
}
