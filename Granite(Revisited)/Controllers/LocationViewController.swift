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
            print("User authorized location")
        }
    }
}
