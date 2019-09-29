//
//  LocationViewController.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 9/27/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class LocationViewController: UIViewController, CLLocationManagerDelegate {
    
    lazy var locationManager: CLLocationManager = self.configureLocationManager()
    
    lazy var exampleView: UIView = self.createExampleView()
    
    var currentCoordinate: CLLocationCoordinate2D?
    var circularRegion: CLCircularRegion?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        
        
        self.locationManager.delegate = self
        self.locationManager.requestAlwaysAuthorization()
    }
}    


// Factory Extension
extension LocationViewController {
    func createExampleView() -> UIView {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }
}

// Layout Extension
extension LocationViewController {
    func layout() {
        layoutExampleView()
    }
    
    func layoutExampleView() {
        self.view.addSubview(self.exampleView)
        
        self.exampleView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}


// Location Manager Extension
extension LocationViewController {
    func configureLocationManager() -> CLLocationManager {
        let locationManager = CLLocationManager()
        return locationManager
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.distanceFilter = CLLocationDistance(exactly: 60)! // TEN MILES IN METERS
            //nerd
            locationManager.startUpdatingLocation()
            startMonitoringRegion()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.currentCoordinate = locations[0].coordinate
        guard let currentCoordinate = self.currentCoordinate else {return}
         let location = Location(latitude: Float(currentCoordinate.latitude), longitude: Float(currentCoordinate.longitude))
        
    
        
        postLocation(withLocation: location) { (location, error) in
            print(location, error)
        }
        
        // Update occurs every 50 meters thefore a network request will happen to save the users location
        
        // Then we fetch all the users in the new location TWO NETWORK Requests
        self.circularRegion = CLCircularRegion(center: currentCoordinate, radius: 50, identifier: "region")
        
    }
    
    func startMonitoringRegion() {
        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
            guard let circularRegion = self.circularRegion else {return}
            circularRegion.notifyOnEntry = true
            circularRegion.notifyOnExit = true
            self.locationManager.startMonitoring(for: circularRegion)
        }
    }
}
