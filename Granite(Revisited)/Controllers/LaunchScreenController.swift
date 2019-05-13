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
    
    var signupButton: UIButton!
    
    var loginButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.shapeLayer = CAShapeLayer()
        self.pulsatingLayer = CAShapeLayer()
        
        //        configureEnterButton(withPulsatingLayer: &self.pulsatingLayer, withShapeLayer: &self.shapeLayer, onView: self.view)
        configureAnimation()
        configureGraniteLabel()
        configureDescriptionLabel()
        configureLogin()
        configureSignup()
    }
    
    private func configureAnimation() {
        self.view.backgroundColor = UIColor(hexString: "c9ddff")
        
        let animationView = LOTAnimationView(name: "launchAnimation")
        animationView.contentMode = .scaleAspectFit
        
        
        animationView.loopAnimation = true
        self.view.addSubview(animationView)
        
        let padding = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: -10)
        animationView.fillSuperview(withSuperview: self.view, padding: padding)
        
        animationView.frame = self.view.bounds
        
        animationView.center.y = self.view.frame.height * 0.2
        
        animationView.animationSpeed = 2
        
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
    
    private func configureLogin() {
        let frame = CGRect(x: self.view.center.x, y: self.view.frame.height * 0.9, width: self.view.frame.width / 1.25, height: 50)
        loginButton = UIButton(frame: frame)
        
        
        loginButton.setTitle("I HAVE AN ACCOUNT", for: .normal)
        
        loginButton.center.x = self.view.center.x
        
        loginButton.layer.cornerRadius = loginButton.frame.height / 2
        loginButton.clipsToBounds = true
        
        loginButton.setTitleColor(UIColor(hexString: "4f6d7a"), for: .normal)
        
        self.view.addSubview(loginButton)
        loginButton.backgroundColor = UIColor(hexString: "c2f8cb")
        loginButton.anchorSize(toView: self.view)
    }
    
    private func configureSignup() {
        
        let frame = CGRect(x: self.view.center.x, y: self.view.frame.height * 0.80, width: self.view.frame.width / 1.25, height: 50)
        signupButton = UIButton(frame: frame)
        
        
        signupButton.setTitle("SIGN UP", for: .normal)
        
        signupButton.center.x = self.view.center.x
        
        signupButton.layer.cornerRadius = loginButton.frame.height / 2
        signupButton.clipsToBounds = true
        
        signupButton.setTitleColor(UIColor(hexString: "c2f8cb"), for: .normal)
        
        self.view.addSubview(signupButton)
        signupButton.backgroundColor = UIColor(hexString: "4f6d7a")
        signupButton.anchorSize(toView: self.view)
        
        // MARK: TODO Would it be better if these elements were arranged into a stack view?
    }
}



