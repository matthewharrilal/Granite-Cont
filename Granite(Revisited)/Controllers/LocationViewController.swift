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
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            startMonitoringRegion()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.currentCoordinate = locations[0].coordinate
        guard let currentCoordinate = self.currentCoordinate else {return}
        print(currentCoordinate)
        
        self.circularRegion = CLCircularRegion(center: currentCoordinate, radius: 50, identifier: "region")
        
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("SOMEONE ENTERED")
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
