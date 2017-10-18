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
    @IBOutlet weak var yesNoSegmentedControl :UISegmentedControl!
    
    var textLayer :CATextLayer = CATextLayer()
    
    var flood :Flood! {
        
        didSet {
            
            self.reportAtLabel.text = flood.reportedAt
            
        }
    }
    
    init(frame :CGRect, flood: Flood) {
        super.init(frame: frame)
        
        self.flood = flood
    }
    
    func setYesCount(count :Int) {
        self.textLayer.string = "\(count)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.backgroundColor = UIColor(fromHexString: "3498db")
        self.layer.cornerRadius = 16.0
        self.layer.masksToBounds = false
        self.clipsToBounds = false
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 5.0
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 0.4
        
    }
    
    override func draw(_ rect: CGRect) {
        
        let circleLayer = CAShapeLayer()

        let rect = CGSize(width: 50, height: 50)

        circleLayer.path = UIBezierPath(ovalIn: CGRect(origin: CGPoint.zero, size: rect)).cgPath
        circleLayer.frame = CGRect(origin: CGPoint(x:self.frame.width - 30 ,y:-15), size: rect)
        circleLayer.fillColor = UIColor(fromHexString: "e74c3c").cgColor

        self.textLayer.font = UIFont.preferredFont(forTextStyle: .caption1)
        self.textLayer.fontSize = 16

        self.textLayer.foregroundColor = UIColor.white.cgColor
        self.textLayer.backgroundColor = UIColor.clear.cgColor
        self.textLayer.alignmentMode = kCAAlignmentCenter
        self.textLayer.frame = CGRect(x: 0 , y: 25/2  , width: circleLayer.frame.width, height: circleLayer.frame.height)

        circleLayer.addSublayer(self.textLayer)
        self.layer.addSublayer(circleLayer)
        
        
    }
    
}
