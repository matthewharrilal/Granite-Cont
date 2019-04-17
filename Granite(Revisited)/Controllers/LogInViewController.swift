//
//  LogInViewController.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 4/17/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit


class LogInViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let loginView = LoginView()
//
//        loginView.frame = self.view.bounds
//
//        self.view.addSubview(loginView)
        
        drawArch()
    }
    
    
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
}
