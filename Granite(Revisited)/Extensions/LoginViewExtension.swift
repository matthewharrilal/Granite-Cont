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

extension LogInViewController {
    func drawArch() {
        let shapeLayer = CAShapeLayer()
        
        let center = CGPoint(x: self.view.center.x, y: self.view.center.y)
        
        let radius = self.view.frame.width / 2
        
        let semiCirclePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: CGFloat.pi, endAngle: 0, clockwise: true)
        
        shapeLayer.path = semiCirclePath.cgPath
        shapeLayer.strokeEnd = 0
        shapeLayer.strokeColor = UIColor(hexString: "98c9a3").cgColor
        shapeLayer.lineWidth = 10
        
        self.view.layer.addSublayer(shapeLayer)
        
    }
    
    func configureAnimation() {
        self.view.backgroundColor = UIColor(hexString: "c9ddff")
        
        let animationView = LOTAnimationView(name: "lazyNight")
        animationView.contentMode = .scaleAspectFit
        
        
        animationView.loopAnimation = true
        self.configuredView.addSubview(animationView)
        
        animationView.frame = self.configuredView.bounds
        
        animationView.play { (completed) in
            print("Has completed animation? -> \(completed)")
        }
    }
    
    
    func addConfiguredView() {
        let frame = CGRect(x: self.view.frame.minX, y: self.view.frame.minY, width: self.view.frame.width, height: self.view.frame.height / 2)
        configuredView = UIView(frame: frame)
        
        //        configuredView.backgroundColor = .red
        
        self.view.addSubview(configuredView)
        
    }
}
