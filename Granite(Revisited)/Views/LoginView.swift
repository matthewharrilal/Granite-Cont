//
//  LoginView.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 4/17/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit
import Lottie

class LoginView: UIView {
    
    @IBOutlet weak var whiteLoginView: UIView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    
    @IBOutlet weak var lockView: UIView!
    
    var loginStackView: UIStackView!
    
    var shapeLayer: CAShapeLayer!
    
    var configuredView: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        
        //        addConfiguredView()
        
        //        configureAnimation()
    }
    
    private func commonInit() {
        print("Loading login view")
        Bundle.main.loadNibNamed("LoginView", owner: self, options: nil)
        addSubviews(views: whiteLoginView, createAccountButton)
        whiteLoginView.addSubviews(views: usernameTextField, passwordTextField, loginButton)
        
        whiteLoginView.layer.cornerRadius = 20
        
        loginStackView = UIStackView(arrangedSubviews: [usernameTextField, passwordTextField , loginButton, createAccountButton])
        loginStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let padding = UIEdgeInsets(top: 10, left: 10, bottom: -10 , right: -10)
        loginStackView.axis = .vertical
        
        loginStackView.spacing = 20
        
        loginStackView.distribution = .fillEqually
        
        whiteLoginView.addSubview(loginStackView)
        
        //        loginStackView.anchorSize(toView: whiteLoginView)
        
        loginStackView.fillSuperview(withSuperview: whiteLoginView, padding: padding)
        
        loginStackView.centerInSuperview()
        
    }
    
    
    func configureLockAnimation() {
        
        let animationView = LOTAnimationView(name: "lock")
        animationView.contentMode = .scaleToFill
        
        animationView.layer.shadowColor = UIColor.black.cgColor
        animationView.layer.shadowOpacity = 1
        animationView.layer.shadowRadius = 10
        animationView.layer.shadowOffset = .zero
        
        self.lockView.addSubview(animationView)
        
        
        animationView.frame = self.lockView.bounds
        
        animationView.play { (completed) in
            print("Has completed animation -> \(completed)")
        }
        
        animationView.loopAnimation = true
        animationView.animationSpeed = 2
    }
}

extension UIView {
    func addSubviews(views: UIView...) {
        views.forEach({addSubview($0)})
    }
}
