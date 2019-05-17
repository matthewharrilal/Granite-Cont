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
        
        self.graniteLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 40)
        
        for family: String in UIFont.familyNames
        {
            print("\(family)")
            for names: String in UIFont.fontNames(forFamilyName: family)
            {
                print("== \(names)")
            }
        }
        
        self.graniteLabel.textAlignment = .center
        self.graniteLabel.center.x = self.view.center.x
        self.graniteLabel.animationType = .fade
        self.view.addSubview(graniteLabel)
        
        self.graniteLabel.text = "Granite"
        
        
        self.graniteLabel.anchorSize(toView: self.view)
        
        self.graniteLabel.startAnimation(duration: 1.65) {
            print("Label animating")
        }
    }
    
    func configureDescriptionLabel() {
        let frame = CGRect(x: self.view.center.x, y: 78, width: self.view.frame.width, height: 100)
        self.descriptionLabel = DWAnimatedLabel(frame: frame)
        
        self.descriptionLabel.center.x = self.view.center.x
         self.descriptionLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 22)
        
        self.descriptionLabel.textAlignment = .center
        self.descriptionLabel.animationType = .typewriter
        self.view.addSubview(descriptionLabel)
        
        self.descriptionLabel.text = "Find developers near you"
//        self.descriptionLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        self.descriptionLabel.startAnimation(duration: 1.5) {
            print("Label animating")
        }
    }
    
    func configureButton(withButton button: inout UIButton, withTarget target: Selector, withBackgroundColorHexString backgroundHexString: String, withTextColorHexString titleHexString: String, withTitle title: String) {
        
        button.setTitle(title, for: .normal)
        
        button.center.x = self.view.center.x
        
        button.layer.cornerRadius = button.frame.height / 2
        button.clipsToBounds = true
        
        // c2f8cb 4f6d7a
        button.setTitleColor(UIColor(hexString: titleHexString ), for: .normal)
        
        button.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        
        self.view.addSubview(button)
        button.backgroundColor = UIColor(hexString: backgroundHexString)
        button.anchorSize(toView: self.view)
        
        button.addTarget(self, action: target, for: .touchUpInside)
    }
}
