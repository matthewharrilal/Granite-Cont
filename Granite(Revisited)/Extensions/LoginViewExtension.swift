//
//  LoginViewExtension.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 4/17/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit
import Lottie

extension LoginView {
    
    func configureAnimation() {
        self.backgroundColor = UIColor(hexString: "c9ddff")
        
        let animationView = LOTAnimationView(name: "lazyNight")
        animationView.contentMode = .scaleAspectFit
        
        animationView.layer.shadowColor = UIColor.black.cgColor
        animationView.layer.shadowOpacity = 1
        animationView.layer.shadowRadius = 10
        animationView.layer.shadowOffset = .zero
        
       
        
        self.configuredView.addSubview(animationView)
        
        animationView.anchorSize(toView: self.configuredView)
        
        animationView.frame = self.configuredView.bounds
        
        animationView.play { (completed) in
            print("Has completed animation? -> \(completed)")
        }
        
         animationView.loopAnimation = true
    }
    
    
    func addConfiguredView() {
        let frame = CGRect(x: self.frame.minX, y: self.frame.minY, width: self.frame.width, height: self.frame.height / 2.5)
        configuredView = UIView(frame: frame)
        
        self.addSubview(configuredView)
        
        configuredView.anchorSize(toView: self)
        
    }
}
