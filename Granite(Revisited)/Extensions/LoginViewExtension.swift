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
        
        let animationView = LOTAnimationView(name: "office")
        animationView.contentMode = .scaleAspectFit
       
        
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
        
        configuredView.anchor(top: self.safeAreaLayoutGuide.topAnchor, leading: self.safeAreaLayoutGuide.leadingAnchor, bottom: self.whiteLoginView.topAnchor, trailing: self.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 20, left: 0, bottom: -20, right: -40))

    }
}
