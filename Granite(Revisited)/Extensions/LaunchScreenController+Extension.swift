//
//  LaunchScreenController+Extension.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 4/18/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit

extension LaunchScreenViewController {
    func configurePulsatingLayer() {
        self.pulsatingLayer = CAShapeLayer()
        
        let circularPath = UIBezierPath(arcCenter: .zero , radius: 50, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        self.pulsatingLayer.path = circularPath.cgPath
        
        self.pulsatingLayer.position = CGPoint(x: self.view.center.x, y: 700)
        
        self.pulsatingLayer.strokeColor = UIColor.clear.cgColor
        
        self.pulsatingLayer.fillColor = UIColor(hexString: "98c9a3").cgColor
        
        self.pulsatingLayer.lineCap = .round
        
        self.pulsatingLayer.strokeEnd = 0
        
        self.view.layer.addSublayer(pulsatingLayer)
    }
    
    func animatePulsatingLayer() {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        
        animation.toValue = 1.3
        
        animation.duration = 0.75
        
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        
        self.pulsatingLayer.add(animation, forKey: "pulse")
    }
    
}
