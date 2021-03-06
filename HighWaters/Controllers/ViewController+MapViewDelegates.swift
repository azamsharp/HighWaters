//
//  ViewController+CoreLocation.swift
//  HighWaters
//
//  Created by Mohammad Azam on 10/17/17.
//  Copyright © 2017 Mohammad Azam. All rights reserved.
//

import Foundation
import MapKit

extension ViewController {
    
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
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: floodAnnotationViewIdentifier) as? FloodAnnotationView
        
        if annotationView == nil {
            
            annotationView = FloodAnnotationView(annotation: annotation as! FloodAnnotation, reuseIdentifier: floodAnnotationViewIdentifier)
            
        }
        
        return annotationView
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
        
        let fancyCalloutView = FancyCalloutView(frame: CGRect(x:-244/2 + 15,y:-180,width:244,height:187), flood: annotation.flood)
        fancyCalloutView.delegate = self
        
         view.addSubview(fancyCalloutView)
    }
    
}





