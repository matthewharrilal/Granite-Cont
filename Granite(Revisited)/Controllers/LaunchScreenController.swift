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
        let shapeLayer = CAShapeLayer()
        
        let position = CGPoint(x: 153, y: 754)
        
        let circularPath = UIBezierPath(arcCenter: position, radius: 50, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor(hexString: "98c9a3").cgColor
        shapeLayer.lineWidth = 10
        
        
        self.view.layer.addSublayer(shapeLayer)
    }

}
