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
        
        let padding = UIEdgeInsets(top: 0, left: 10, bottom: -100, right: -10)
        animationView.fillSuperview(withSuperview: self.view, padding: padding)
        
        animationView.frame = self.view.bounds
        
        
        animationView.animationSpeed = 2
        
        animationView.play { (completed) in
            print("Has completed animation? -> \(completed)")
        }
    }
    
    // TODO: MARK Handle tap
    private func transitionToLogin() {
        let loginViewController = LogInViewController()
        loginViewController.hero.isEnabled = true
        
        loginViewController.hero.modalAnimationType = .fade
        self.present(loginViewController, animated: true, completion: nil)
    }
    
    // MARK: FIX Same logic as the configure login and sign up button
    private func configureLogin() {
        let frame = CGRect(x: self.view.center.x, y: self.view.frame.height * 0.86, width: self.view.frame.width / 1.25, height: 50)
        
        self.loginButton = UIButton(frame: frame)
        configureButton(withButton: &loginButton, withTarget: #selector(handleLogin), withBackgroundColorHexString: "61988e", withTextColorHexString: "9cfc97" , withTitle: "I HAVE AN ACCOUNT ")
    }
    
    private func configureSignup() {
        
        let frame = CGRect(x: self.view.center.x, y: self.view.frame.height * 0.78, width: self.view.frame.width / 1.25, height: 50)
        
        self.signupButton = UIButton(frame: frame)
        configureButton(withButton: &signupButton, withTarget: #selector(handleSignUp), withBackgroundColorHexString: "9cfc97", withTextColorHexString: "61988e", withTitle: "SIGN UP")
        
        // MARK: TODO Would it be better if these elements were arranged into a stack view?
    }
    
    
    @objc func handleLogin() {
        print("Tapping Login")
        transitionToLogin()
    }
    
    @objc func handleSignUp() {
        print("Tapping sign up")
    }
}



