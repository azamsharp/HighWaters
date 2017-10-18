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

class Flood {
    
    var coordinate :CLLocationCoordinate2D
    var reportedAt :String
    var yesCount :Int? = 0
    var ref :DatabaseReference!
    
    func toDictionary() -> [String:Any] {
        
        return ["latitude":self.coordinate.latitude,"longitude":self.coordinate.longitude,
                "reportedAt":self.reportedAt, "yesCount": self.yesCount!
        ]
    }
    
    init(coordinate :CLLocationCoordinate2D, reportedAt :String) {
        self.coordinate = coordinate
        self.reportedAt = reportedAt
    }
    
    init?(snapshot :DataSnapshot) {
        
        guard let snapshotDictionary = snapshot.value as? [String:Any] else {
            return nil
        }
        
        guard let latitude = snapshotDictionary["latitude"] as? Double,
            let longitude = snapshotDictionary["longitude"] as? Double,
            let reportedAt = snapshotDictionary["reportedAt"] as? String,
            let yesCount = snapshotDictionary["yesCount"] as? Int
            else {
                return nil
        }
        
        self.reportedAt = reportedAt
        self.yesCount = yesCount
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}


