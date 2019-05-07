//
//  ViewController.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 4/17/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import UIKit
import Lottie
import Hero
import DWAnimatedLabel

class LaunchScreenViewController: UIViewController {
    
    var enterButton: UIButton!
    
    var shapeLayer: CAShapeLayer!
    
    var pulsatingLayer: CAShapeLayer!
    
    var touchView: UIView!
    
    var graniteLabel: DWAnimatedLabel!
    
    var descriptionLabel: DWAnimatedLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.shapeLayer = CAShapeLayer()
        self.pulsatingLayer = CAShapeLayer()
        
        configureEnterButton(withPulsatingLayer: &self.pulsatingLayer, withShapeLayer: &self.shapeLayer, onView: self.view)
        configureAnimation()
        configureGraniteLabel()
        configureDescriptionLabel()
    }

    private func configureAnimation() {
        self.view.backgroundColor = UIColor(hexString: "c9ddff")
        
        let animationView = LOTAnimationView(name: "launchAnimation")
        animationView.contentMode = .scaleAspectFit
        
        
        animationView.loopAnimation = true
        self.view.addSubview(animationView)
        
        let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -10)
        animationView.fillSuperview(withSuperview: self.view, padding: padding)
        
        animationView.frame = self.view.bounds
        
        animationView.animationSpeed = 2
                
//        self.pulsatingLayer.position = CGPoint(x: self.view.center.x, y: self.view.frame.height * scaleFactor)
//        self.shapeLayer.position = CGPoint(x: self.view.center.x, y: self.view.frame.height *  0.9)
        
        animationView.play { (completed) in
            print("Has completed animation? -> \(completed)")
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first // Get the first touch of the user
        
        guard let point = touch?.location(in: self.view) else {return}
        
        let convertedPoint = self.view.layer.convert(point, to: self.shapeLayer)
        
        // Have to check if the path of the shape layer contains the point not the shape layer itself
        if let path = self.shapeLayer.path, path.contains(convertedPoint) {
            transitionToLogin()
        }
    }
    
    // TODO: MARK Handle tap
    private func transitionToLogin() {
        let loginViewController = LogInViewController()
        loginViewController.hero.isEnabled = true
        
        loginViewController.hero.modalAnimationType = .fade
        self.present(loginViewController, animated: true, completion: nil)
    }
}



