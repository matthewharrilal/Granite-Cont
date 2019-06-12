//
//  SignUpView.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 6/6/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit
import Lottie

class SignUpView: UIView, UITextFieldDelegate {
    @IBOutlet weak var animationContainerView: UIView!
    @IBOutlet weak var createAccountView: UIView!
    @IBOutlet weak var transitionView: UIView!
    var innerContainerView: UIView!
    var animationView: LOTAnimationView!
    var signUpLabel: UILabel!
    var textFieldView: UIView!
    var placeholderLabel: UILabel!
    var passwordPlaceholderLabel: UILabel!
    var usernameTextField: UITextField!
    var passwordTextField: UITextField!
    lazy var usernameBorder = CALayer()
    lazy var passwordBorder = CALayer()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        
        animateInnerContainerView()
        
        animateCreateAccountView()
        
        
        // Username
        createCustomTextField(withPoint: .init(x: self.innerContainerView.bounds.minX, y: self.innerContainerView.bounds.minY + 20), withBottomBorder: &usernameBorder)
        
        // Password
        createPasswordTextField(withPoint: .init(x: self.innerContainerView.bounds.minX, y: self.innerContainerView.bounds.midY), withBottomBorder: &passwordBorder)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("SignUpView", owner: self, options: nil)
        addSubviews(views: animationContainerView, createAccountView)
        self.animationContainerView.frame = .init(x: self.bounds.minX, y: self.bounds.minY, width: self.bounds.width, height: self.bounds.height / 3)
        
        self.createAccountView.frame = .init(x: self.bounds.midX, y: createAccountView.bounds.origin.y, width: -self.bounds.width, height: self.bounds.height / 2)
        
        
        self.backgroundColor = .init(hexString: "d5b9b2")
        
        
        loadAnimationView()
        
        self.createAccountView.backgroundColor = .blue
        
        
        createInnerContainerView()
    }
    
    func loadAnimationView() {
        self.animationView = LOTAnimationView(name: "lego")
        animationView.frame = self.animationContainerView.bounds
        
        self.animationContainerView.addSubview(animationView)
        self.animationContainerView.backgroundColor = .init(hexString: "d5b9b2")
        animationView.autoReverseAnimation = true
        animationView.loopAnimation = true
    }
    
    func createInnerContainerView() {
        self.createAccountView.layer.cornerRadius = 50
        self.createAccountView.backgroundColor = .init(hexString: "7f7eff")
        
        self.innerContainerView = UIView(frame: .init(x: self.createAccountView.bounds.origin.x, y: self.createAccountView.bounds.origin.y, width: self.bounds.width, height: -self.createAccountView.bounds.height))
        innerContainerView.backgroundColor = .white
        
        self.addSubview(innerContainerView)
        
        
        innerContainerView.layer.cornerRadius = 50
        
        
        
    }
    
    func animateInnerContainerView() {
        
        UIView.animate(withDuration: 2.0, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1, options: .curveEaseInOut, animations: {
            self.innerContainerView.frame = .init(x: self.createAccountView.bounds.origin.x, y: self.createAccountView.bounds.origin.y, width: self.bounds.width, height: self.createAccountView.bounds.height)
        }, completion: {_ in
        })
        
        self.innerContainerView.anchor(top: self.createAccountView.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 50, left: 50, bottom: 50, right: -70))
    }
    
    func animateCreateAccountView() {
        UIView.animate(withDuration: 2.0, delay: 0.1, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1, options: .curveEaseInOut, animations: {
            self.createAccountView.frame = .init(x: self.createAccountView.bounds.midX, y: self.createAccountView.bounds.origin.y, width: self.bounds.width, height: self.createAccountView.bounds.height)
        }, completion: { _ in
            self.animationView.play()
            self.createOuterContainerLabel()
        })
        
        self.createAccountView.anchor(top: self.animationContainerView.bottomAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 10, left: -50, bottom: 50, right: -50))
        self.layoutIfNeeded()
    }
    
    
    func createOuterContainerLabel() {
        self.signUpLabel = UILabel(frame: .init(x: self.createAccountView.bounds.minX, y: self.createAccountView.bounds.minY, width: self.createAccountView.bounds.width / 2, height: self.createAccountView.bounds.height  - self.innerContainerView.bounds.height))
        
        signUpLabel.center.x = self.createAccountView.bounds.midX
        
        signUpLabel.text = "Sign Up"
        signUpLabel.textColor = .white
        self.createAccountView.addSubview(signUpLabel)
        
        signUpLabel.textAlignment = .center
        
    }
    
    func createCustomTextField(withPoint cgPoint: CGPoint, withBottomBorder bottomBorder: inout CALayer) {
        
        
        self.textFieldView = UIView(frame: .init(x: cgPoint.x, y: cgPoint.y , width: self.innerContainerView.frame.width / 2, height: 60))
        
        textFieldView.backgroundColor = .clear
        
        self.placeholderLabel = UILabel()
        placeholderLabel.text = ""
        
        self.usernameTextField = UITextField()
        self.usernameTextField.delegate = self
        usernameTextField.borderStyle = .none
        usernameTextField.layer.borderColor = UIColor.init(hexString: "8CDFD6").cgColor
        usernameTextField.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
        usernameTextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTextFieldTap)))
        
        usernameTextField.backgroundColor = .clear
        usernameTextField.placeholder = "Username"
        
        let stackView = UIStackView(arrangedSubviews: [placeholderLabel, usernameTextField])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 5
        
        stackView.backgroundColor = .blue
        
        
        usernameTextField.constrainHeight(withHeight: stackView.frame.height / 2)
        usernameTextField.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
        
        textFieldView.addSubview(stackView)
        stackView.frame = textFieldView.bounds
        stackView.anchor(top: textFieldView.topAnchor, leading: textFieldView.leadingAnchor, bottom: textFieldView.bottomAnchor, trailing: textFieldView.trailingAnchor, padding: .init(top: 10, left: 0, bottom: -10, right: 0))
        
        
        self.innerContainerView.addSubview(textFieldView)
        textFieldView.center.x = self.innerContainerView.bounds.midX
        stackView.center.x = textFieldView.bounds.midX
        
        placeholderLabel.anchor(top: stackView.topAnchor, leading: stackView.leadingAnchor, bottom: usernameTextField.topAnchor, trailing: stackView.trailingAnchor)
        usernameTextField.constrainWidth(withWidth: stackView.bounds.width)
        
        createViewBorder(withSuperLayer: textFieldView, withBorder: &bottomBorder)
    }
    
    func createPasswordTextField(withPoint cgPoint: CGPoint, withBottomBorder bottomBorder: inout CALayer) {
        
        
        self.textFieldView = UIView(frame: .init(x: cgPoint.x, y: cgPoint.y , width: self.innerContainerView.frame.width / 2, height: 60))
        
        textFieldView.backgroundColor = .clear
        
        self.passwordPlaceholderLabel = UILabel()
        passwordPlaceholderLabel.text = ""
        
        self.passwordTextField = UITextField()
        self.passwordTextField.delegate = self
        passwordTextField.borderStyle = .none
        passwordTextField.layer.borderColor = UIColor.init(hexString: "8CDFD6").cgColor
        passwordTextField.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
        passwordTextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlePasswordTextFieldTap)))
        
        passwordTextField.backgroundColor = .clear
        passwordTextField.placeholder = "Password"
        
        let stackView = UIStackView(arrangedSubviews: [passwordPlaceholderLabel, passwordTextField])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 5
        
        stackView.backgroundColor = .blue
        
        
        passwordTextField.constrainHeight(withHeight: stackView.frame.height / 2)
        passwordTextField.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
        
        textFieldView.addSubview(stackView)
        stackView.frame = textFieldView.bounds
        stackView.anchor(top: textFieldView.topAnchor, leading: textFieldView.leadingAnchor, bottom: textFieldView.bottomAnchor, trailing: textFieldView.trailingAnchor, padding: .init(top: 10, left: 0, bottom: -10, right: 0))
        
        
        self.innerContainerView.addSubview(textFieldView)
        textFieldView.center.x = self.innerContainerView.bounds.midX
        stackView.center.x = textFieldView.bounds.midX
        
        passwordPlaceholderLabel.anchor(top: stackView.topAnchor, leading: stackView.leadingAnchor, bottom: passwordTextField.topAnchor, trailing: stackView.trailingAnchor)
        passwordTextField.constrainWidth(withWidth: stackView.bounds.width)
        
        createViewBorder(withSuperLayer: textFieldView, withBorder: &bottomBorder)
    }
    
    @objc func handleTextFieldTap() {
        self.placeholderLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
        self.placeholderLabel.text = "Username"
        self.placeholderLabel.alpha = 0.0
        UIView.animate(withDuration: 1.0) {
            self.usernameTextField.placeholder = ""
            self.placeholderLabel.alpha = 0.8
            
            animateViewBorder(withHexColor: "8CDFD6", withBorder: &self.usernameBorder)
        }
    }
    
    @objc func handlePasswordTextFieldTap() {
        self.passwordPlaceholderLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
        self.passwordPlaceholderLabel.text = "Password"
        self.passwordPlaceholderLabel.alpha = 0.0
        UIView.animate(withDuration: 1.0) {
            self.passwordTextField.placeholder = ""
            self.passwordPlaceholderLabel.alpha = 0.8
            
            animateViewBorder(withHexColor: "8CDFD6", withBorder: &self.passwordBorder)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        textField.endEditing(true)
        
        return true
    }
    
}
