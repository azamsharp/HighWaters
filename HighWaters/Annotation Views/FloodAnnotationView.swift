//
//  FloodAnnotationView.swift
//  HighWaters
//
//  Created by Mohammad Azam on 10/12/17.
//  Copyright © 2017 Mohammad Azam. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import MapKit

class FloodAnnotationView : MKAnnotationView {
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        var frame = self.frame
        frame.size = CGSize(width: 30, height: 30)
        self.frame = frame
        
        self.backgroundColor = UIColor.clear
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        let hitView = super.hitTest(point, with: event)
        
        if let hitView = hitView {
            self.superview?.bringSubview(toFront: hitView)
        }
        
        return hitView
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
       
        let rect: CGRect = bounds
        var isInside: Bool = rect.contains(point)
        if !isInside {
            for view: UIView in subviews {
                isInside = view.frame.contains(point)
                if isInside {
                    break
                }
            }
        }
        return isInside
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        
        UIImage(named: "pin")?.draw(in: CGRect(x: 0, y: 0, width: 30, height: 30))
    }
    
}
