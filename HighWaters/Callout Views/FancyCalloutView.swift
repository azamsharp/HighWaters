//
//  FancyCallout.swift
//  HighWaters
//
//  Created by Mohammad Azam on 10/17/17.
//  Copyright © 2017 Mohammad Azam. All rights reserved.
//

import UIKit

class FancyCalloutView: UIView {
    
  
    @IBOutlet var contentView: UIView!
    @IBOutlet var reportedAtLabel: UILabel!
    
    var flood :Flood!
    
    init(frame :CGRect, flood :Flood) {
        super.init(frame: frame)
        self.flood = flood
        
        commonInit()
        initializeUI()
    }
    
    private func initializeUI() {
        
        self.reportedAtLabel.text = self.flood.reportedAt
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        
        self.contentView = Bundle.main.loadNibNamed("FancyCalloutView", owner: self, options: nil)?.last as! UIView
        self.contentView.frame = self.bounds 
        self.addSubview(contentView)
    }
   
}
