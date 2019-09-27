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
    
    var createAccountTapClosure: (() -> Void)?
    var loginTapClosure: (() -> Void)?

    
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
    }
    
    
    
    private func commonInit() {
        print("Loading login view")
        Bundle.main.loadNibNamed("LoginView", owner: self, options: nil)
        addSubviews(views: whiteLoginView)
        
        usernameTextField.borderStyle = .none
        passwordTextField.borderStyle = .none
        
        usernameTextField.textAlignment = .left
        passwordTextField.textAlignment = .left
        
        
        
        let textFieldComponentsStackview = UIStackView(arrangedSubviews: [usernameTextField, passwordTextField])
        textFieldComponentsStackview.layoutMargins = .init(top: 0, left: 10, bottom: 0, right: 10)
        textFieldComponentsStackview.isLayoutMarginsRelativeArrangement =  true
        
        textFieldComponentsStackview.distribution = .fillProportionally
        textFieldComponentsStackview.axis = .vertical
    
    
        
        let loginButtonContainer = self.createLoginButtonContainer()
        
        loginButtonContainer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleLogin)))
        
        
        let createAccountContainer = self.createAccountButtonContainer()
        createAccountContainer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleCreateAccount)))
        
        
        loginStackView = UIStackView(arrangedSubviews: [textFieldComponentsStackview, loginButtonContainer, createAccountContainer])
       
        loginStackView.axis = .vertical
        loginStackView.spacing = 10
        loginStackView.distribution = .fillEqually

   
        whiteLoginView.addSubview(loginStackView)
        let padding = UIEdgeInsets(top: 10, left: 20, bottom: -10 , right: -20)
        loginStackView.fillSuperview(withSuperview: whiteLoginView, padding: padding)
        
        whiteLoginView.layer.cornerRadius = 20
        
        loginStackView.layoutMargins = .init(top: 0, left: 0, bottom: 0, right: -10)
        loginStackView.isLayoutMarginsRelativeArrangement = true
        
    }
    
    
    @objc func handleCreateAccount() {
        self.createAccountTapClosure?()
    }
    
    @objc func handleLogin() {
        self.loginTapClosure?()
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
    
    
    func createAccountButtonContainer() -> TouchableBounceView {
        let container = TouchableBounceView()
        
        let containerView = UIView()
        
        container.addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        let label = UILabel()
        containerView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        label.text = "Don't Have an Account?"
        label.font = .boldSystemFont(ofSize: 17)
        
        return container
    }
    
    
    func createLoginButtonContainer() -> TouchableBounceView {
        let container = TouchableBounceView()
        
        let containerView = UIView()
        
//        container.backgroundColor = UIColor(hexString: "2357A5")
        
        container.addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        let label = UILabel()
        containerView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        label.text = "Log In"
//        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 20)
        
        return container
    }
}

