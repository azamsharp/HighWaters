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

    @IBOutlet weak var mapView :MKMapView!
    lazy var locationManager = CLLocationManager()
    var floodedLocationsRef :DatabaseReference!
    var floodedLocations :[Flood] = [Flood]()
    
    @IBOutlet weak var floodCalloutView :FloodCalloutView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeFirebase()
        populateFloodedLocations()
        initializeLocation()
    }
    
    private func initializeFirebase() {
        
        self.floodedLocationsRef = Database.database().reference(withPath: "flooded-locations")
    }
    
    private func populateFloodedLocations() {
        
        self.floodedLocationsRef.observe(.value) { [weak self] snapshot in
            
            self?.floodedLocations = snapshot.children.flatMap { snap in
                return Flood(snapshot: snap as! DataSnapshot)
            }
            
            DispatchQueue.main.async {
             
                self?.floodedLocations.forEach { flood in
                    
                    let annotation = FloodAnnotation(flood: flood)
                    self?.mapView.addAnnotation(annotation)
                    
                }
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
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "FloodAnnotationView") as? FloodAnnotationView
        
        if annotationView == nil {
            
            annotationView = FloodAnnotationView(annotation: annotation as! FloodAnnotation, reuseIdentifier: "FloodAnnotationView")
            
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        
        if let userAnnotationView = views.first {
            if let annotation = userAnnotationView.annotation {
                if annotation is MKUserLocation {
                    
                    let region :MKCoordinateRegion = MKCoordinateRegion(center: self.mapView.userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
                    self.mapView.setRegion(region, animated: true)
                    
                }
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        
        _ = view.subviews.map { subView in
            subView.removeFromSuperview()
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        guard let annotation = view.annotation as? FloodAnnotation else {
            return
        }
        
        self.floodCalloutView.reportAtLabel.text = annotation.flood.reportedAt
        view.addSubview(self.floodCalloutView)
    }
    
    @IBAction func markAsFloodedButtonPressed() {
        
        let coordinate = self.mapView.userLocation.coordinate
        
        // get the current date
        let reportedAt = Date().toString(format: "MM-dd-yyyy HH:mm:ss")
        
        // save the flood object to the firebase database
        let flood = Flood(coordinate: coordinate,reportedAt :reportedAt)
        
        let annotation = FloodAnnotation(flood: flood)
        self.mapView.addAnnotation(annotation)
        
        let floodRef = self.floodedLocationsRef.childByAutoId()
        floodRef.setValue(flood.toDictionary())
        
    }


}

