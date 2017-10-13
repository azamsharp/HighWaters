//
//  Extensions.swift
//  HighWaters
//
//  Created by Mohammad Azam on 10/12/17.
//  Copyright © 2017 Mohammad Azam. All rights reserved.
//

import Foundation

extension Date {
    
    func toString(format :String) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
}
