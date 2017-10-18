//
//  HWService.swift
//  HighWaters
//
//  Created by Mohammad Azam on 10/17/17.
//  Copyright © 2017 Mohammad Azam. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class HWService {
    
    var databaseReference :DatabaseReference
    
    init() {
        
        self.databaseReference = Database.database().reference(withPath: "flooded-locations")
    }
    
    func getFloodedLocations(callback :@escaping (([Flood]) -> ())) {
        
        var floodedLocations = [Flood]()
        
        self.databaseReference.observe(.value) { snapshot in
            
            floodedLocations = snapshot.children.flatMap { snap in
                return Flood(snapshot: snap as! DataSnapshot)
            }
            
            DispatchQueue.main.async {
                callback(floodedLocations)
            }
        }
        
    }
    
    func addFlood(flood :Flood) {
        
        let floodRef = self.databaseReference.childByAutoId()
        flood.ref = floodRef
        floodRef.setValue(flood.toDictionary())
    }
    
}
