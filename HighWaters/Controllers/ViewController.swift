//
//  ViewController.swift
//  HighWaters
//
//  Created by Mohammad Azam on 10/10/17.
//  Copyright © 2017 Mohammad Azam. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Firebase
import FirebaseDatabase

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    private let TIME_TO_WAIT = 30.0
    private let DATE_FORMAT = "MM-dd-yyyy HH:mm:ss"
    let floodAnnotationViewIdentifier = "FloodAnnotationView"
    
    @IBOutlet weak var mapView :MKMapView!
    @IBOutlet weak var markAsFloodedButton :UIButton!
    @IBOutlet weak var markAsFloodedButtonHeightConstraint :NSLayoutConstraint!
    
    lazy var locationManager = CLLocationManager()
    
    private var hwService :HWService!
    
    var floodedLocations :[Flood] = [Flood]()
    
    @IBOutlet weak var floodCalloutView :FloodCalloutView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hwService = HWService()
        
        initializeLocation()
        populateFloodedLocations()
    }
    
    private func populateFloodedLocations() {
        
        self.hwService.getFloodedLocations { [weak self] floodedLocations in
            
            for flood in floodedLocations {
               
                let annotation = FloodAnnotation(flood: flood)
                self?.mapView.addAnnotation(annotation)
            }
            
        }
    }
    
    private func initializeLocation() {
        
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = kCLDistanceFilterNone
        
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
        
        self.mapView.delegate = self
        self.mapView.showsUserLocation = true
    }
    
    
    @IBAction func markAsFloodedButtonPressed() {
        
        addFloodedRegion()
    }
    
    private func addFloodedRegion() {
        
        let coordinate = self.mapView.userLocation.coordinate
        let reportedAt = Date().toString(format: DATE_FORMAT)
        
        let flood = Flood(coordinate: coordinate, reportedAt: reportedAt)
        
        self.hwService.addFlood(flood: flood)
        
        let annotation = FloodAnnotation(flood: flood)
        self.mapView.addAnnotation(annotation)
      
        hideMarkAsFloodedButton()
    }
    
    private func hideMarkAsFloodedButton() {
        
        self.markAsFloodedButton.clipsToBounds = true
        self.markAsFloodedButton.setTitle("", for: .normal)
        
        // remove the progressView
        
        let progressView = UIView(frame: CGRect(x: 0, y: self.view.frame.size.height - 5, width: 0, height: 5))
        progressView.backgroundColor = self.markAsFloodedButton.backgroundColor
        self.view.addSubview(progressView)
        
        // look into property animator and see if it can simply the code
        
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            
            self?.markAsFloodedButtonHeightConstraint.constant = 5
            self?.markAsFloodedButton.backgroundColor = UIColor(fromHexString: "e74c3c")
            self?.markAsFloodedButton.layoutIfNeeded()
            
        }) { (_) in
            
            UIView.animate(withDuration: self.TIME_TO_WAIT, animations: {
                
                progressView.frame.size = CGSize(width: self.markAsFloodedButton.frame.width, height: 5)
                progressView.layoutIfNeeded()
                
            }, completion: { (_) in
                
                progressView.removeFromSuperview()
                self.markAsFloodedButton.backgroundColor = UIColor(fromHexString: "2ecc71")
                
                UIView.animate(withDuration: 0.75, animations: {
                    
                    self.markAsFloodedButton.setTitle("MARK AS FLOODED", for: .normal)
                    self.markAsFloodedButtonHeightConstraint.constant = 43
                    self.view.layoutIfNeeded()
                    
                })
                
            })
        }
    }
}


// FancyCallout Delegates
extension ViewController : FancyCalloutViewDelegate {
    
    func fancyCalloutViewDidSelectedYesNoOption(flood: Flood, isYes: Bool,calloutView :FancyCalloutView) {
        
        flood.yesCount += isYes == true ? 1 : -1
        flood.reportedAt = Date().toString(format: DATE_FORMAT)
        
        let floodRef = flood.ref
        floodRef?.setValue(flood.toDictionary())
        
        calloutView.reportedAtLabel.text = flood.reportedAt
        calloutView.yesCountLabel.text = "\(flood.yesCount)"
    }
}










