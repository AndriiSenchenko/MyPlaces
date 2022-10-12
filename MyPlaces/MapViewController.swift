//
//  MapViewController.swift
//  MyPlaces
//
//  Created by Andrey on 12.10.2022.
//  Copyright © 2022 Andrey. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var place: Place!
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPlacemark()
    }
    private func setupPlacemark(){
        guard let location = place.location else { return }
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(location) { (placemarks, error) in
            if let error = error {
                print (error)
                return
            }
            guard let placemarks = placemarks else { return }
            let placemark = placemarks.first
            let anotation = MKPointAnnotation()
            anotation.title = self.place.name
            anotation.subtitle = self.place.type
            guard let placemarkLocation = placemark?.location else { return }
            anotation.coordinate = placemarkLocation.coordinate
            self.mapView.showAnnotations([anotation], animated: true)
            self.mapView.selectAnnotation(anotation, animated: true)
            
        }
    }

    @IBAction func closeVC() {
        dismiss(animated: true)
    }
}
