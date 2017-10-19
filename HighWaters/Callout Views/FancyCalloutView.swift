//
//  FancyCallout.swift
//  HighWaters
//
//  Created by Mohammad Azam on 10/17/17.
//  Copyright © 2017 Mohammad Azam. All rights reserved.
//

import UIKit

protocol FancyCalloutViewDelegate : class {
    
    func fancyCalloutViewDidSelectedYesNoOption(flood :Flood, isYes :Bool, calloutView :FancyCalloutView)
}

class FancyCalloutView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet var reportedAtLabel: UILabel!
    @IBOutlet var yesCountLabel :UILabel!
    @IBOutlet var yesNoSegmentedControl :UISegmentedControl!
    
    weak var delegate :FancyCalloutViewDelegate!
    
    var flood :Flood!
    
    init(frame :CGRect, flood :Flood) {
        super.init(frame: frame)
        self.flood = flood
        
        commonInit()
        initializeUI()
    }
    
    private func initializeUI() {
        
        self.flood.ref.observe(.value) { snapshot in
            
            let changedValues = snapshot.value as! [String:Any]
            
            guard let reportedAt = changedValues["reportedAt"] as? String,
                let yesCount = changedValues["yesCount"] as? Int else {
                    return
            }
            
            
            self.reportedAtLabel.text = reportedAt
            self.yesCountLabel.text = "\(yesCount)"
            
            print(changedValues)
        }
        
       
        self.yesNoSegmentedControl.addTarget(self, action: #selector(yesNoSegmentedControlValueChanged), for: .valueChanged)
    }
    
    @objc func yesNoSegmentedControlValueChanged(segmentedControl :UISegmentedControl) {
        
        let selectedTitle = segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex)
        
        self.delegate.fancyCalloutViewDidSelectedYesNoOption(flood: self.flood, isYes: selectedTitle == "Yes" ? true : false, calloutView: self)
        
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
