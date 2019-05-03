//
//  LaunchScreenController+Extension.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 4/18/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit
import DWAnimatedLabel

extension LaunchScreenViewController {
    func configureGraniteLabel() {
        let frame = CGRect(x: self.view.center.x, y: 44, width: self.view.frame.width, height: 100)
        self.graniteLabel = DWAnimatedLabel(frame: frame)
        
        self.graniteLabel.textAlignment = .center
        self.graniteLabel.center.x = self.view.center.x
        self.graniteLabel.animationType = .fade
        self.view.addSubview(graniteLabel)
        
        self.graniteLabel.text = "Granite"
        self.graniteLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        
        self.graniteLabel.startAnimation(duration: 1.65) {
            print("Label animating")
        }
    }
    
    func configureDescriptionLabel() {
        let frame = CGRect(x: self.view.center.x, y: 70, width: self.view.frame.width, height: 100)
        self.descriptionLabel = DWAnimatedLabel(frame: frame)
        
        self.descriptionLabel.center.x = self.view.center.x
        
        self.descriptionLabel.textAlignment = .center
        self.descriptionLabel.animationType = .typewriter
        self.view.addSubview(descriptionLabel)
        
        self.descriptionLabel.text = "Find developers near you"
        self.descriptionLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        self.descriptionLabel.startAnimation(duration: 1.5) {
            print("Label animating")
        }
    }
    
}
