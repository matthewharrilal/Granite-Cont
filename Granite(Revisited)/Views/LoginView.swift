//
//  LoginView.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 4/17/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit

class LoginView: UIView {
    
    var shapeLayer: CAShapeLayer!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        drawArch()
    }
    
    func drawArch() {
        shapeLayer = CAShapeLayer()
        
        let center = CGPoint(x: self.center.x, y: self.center.y)
        
        let radius = self.frame.width / 2
        
        let semiCirclePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: CGFloat.pi, endAngle: 0, clockwise: true)
        
        shapeLayer.path = semiCirclePath.cgPath
        shapeLayer.strokeEnd = 0
        shapeLayer.strokeColor = UIColor(hexString: "98c9a3").cgColor
        shapeLayer.lineWidth = 10
        
        self.layer.addSublayer(shapeLayer)
        
    }
    
    private func commonInit() {
        print("Loading")
        Bundle.main.loadNibNamed("LoginView", owner: self, options: nil)
        self.backgroundColor = .red
    }
}
