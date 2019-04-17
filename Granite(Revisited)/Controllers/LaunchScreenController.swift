//
//  ViewController.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 4/17/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import UIKit
import Lottie

class LaunchScreenViewController: UIViewController {
    
    let enterButton = UIButton(frame: CGRect(x: 153, y: 754, width: 109, height: 30))
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // MARK: FIX Display animation then transition to initial view of the screen
        configureAnimation()
        configureEnterButton()
    }
    
    
    private func configureAnimation() {
        self.view.backgroundColor = UIColor(hexString: "c9ddff")

        let animationView = LOTAnimationView(name: "launchAnimation")
        animationView.contentMode = .scaleAspectFit
        
        
        animationView.loopAnimation = true
        self.view.addSubview(animationView)
        
        animationView.frame = self.view.bounds
        
        animationView.play { (completed) in
            print("Has completed animation? -> \(completed)")
        }
    }
    
    private func configureEnterButton() {
        var shapeLayer = CAShapeLayer()
        
        let position = CGPoint(x: self.view.center.x, y: 700)
        
        let circularPath = UIBezierPath(arcCenter: position, radius: 50, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeEnd = 0
        shapeLayer.strokeColor = UIColor(hexString: "98c9a3").cgColor
        shapeLayer.lineWidth = 10
        
        animateStroke(with: &shapeLayer)
        
        
        self.view.layer.addSublayer(shapeLayer)
    }
    
    private func animateStroke(with shapeLayer: inout CAShapeLayer) {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        basicAnimation.toValue = 1
        basicAnimation.duration = 1
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayer.add(basicAnimation, forKey: "strokeAnimation")
    }

}
