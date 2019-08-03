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
    
    // MARK: TODO Add Back Button
    
    @IBOutlet weak var whiteLoginView: UIView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    
    @IBOutlet weak var lockView: UIView!
    
    var loginStackView: UIStackView!
    
    var shapeLayer: CAShapeLayer!
    
    var configuredView: UIView!
    
    var keyboardDelegate: KeyboardDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        print("Loading login view")
        Bundle.main.loadNibNamed("LoginView", owner: self, options: nil)
        addSubviews(views: whiteLoginView)
        
        usernameTextField.borderStyle = .none
        passwordTextField.borderStyle = .none
        
        usernameTextField.textAlignment = .left
        passwordTextField.textAlignment = .left
        
        addTargets()
        
        
        loginButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 20)
        createAccountButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 20)
        
        createAccountButton.backgroundColor = .clear
        
        
        // MARK: FIX Have to fix the elements in the stack view sizing
        loginButton.backgroundColor = .clear
        
        loginButton.constrainHeight(withHeight: loginButton.frame.height)
        createAccountButton.constrainHeight(withHeight: createAccountButton.frame.height)
        
        
        
        let textFieldComponentsStackview = UIStackView(arrangedSubviews: [usernameTextField, passwordTextField])
        textFieldComponentsStackview.layoutMargins = .init(top: 0, left: 10, bottom: 0, right: 10)
        textFieldComponentsStackview.isLayoutMarginsRelativeArrangement =  true
        
        textFieldComponentsStackview.distribution = .fillProportionally
        textFieldComponentsStackview.axis = .vertical
        //
        //        loginComponentsStackview.distribution = .fillEqually
        //        loginCompospnentsStackview.axis = .vertical
        
        
        loginStackView = UIStackView(arrangedSubviews: [textFieldComponentsStackview, loginButton, createAccountButton])
        
        //        createAccountButton.anchor(top: loginButton.bottomAnchor, leading: loginStackView.leadingAnchor, bottom: loginStackView.bottomAnchor, trailing: loginStackView.trailingAnchor)
        
        loginStackView.axis = .vertical
        loginStackView.spacing = 10
        loginStackView.distribution = .fillEqually
        
        //        usernameTextField.
        
//        whiteLoginView.frame = .init(x: self.whiteLoginView.frame.origin.x, y: self.whiteLoginView.frame.origin.y, width: self.whiteLoginView.frame.width, height: -whiteLoginView.frame.height)
//        
        whiteLoginView.addSubview(loginStackView)
        let padding = UIEdgeInsets(top: 10, left: 20, bottom: -10 , right: -20)
        loginStackView.fillSuperview(withSuperview: whiteLoginView, padding: padding)
        
        whiteLoginView.layer.cornerRadius = 20
        
        loginStackView.layoutMargins = .init(top: 0, left: 0, bottom: 0, right: -10)
        loginStackView.isLayoutMarginsRelativeArrangement = true
        
    }
    
    func addTargets() {
        usernameTextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        passwordTextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
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
    
    @objc func handleTap() {
         if let keyboardDelegate = self.keyboardDelegate {
            keyboardDelegate.keyboardIsActive()
        }
    }
}

extension UIView {
    func addSubviews(views: UIView...) {
        views.forEach({addSubview($0)})
    }
}

