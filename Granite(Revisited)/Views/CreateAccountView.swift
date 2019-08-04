//
//  CreateAccountView.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 8/3/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit
import Lottie
import SnapKit

class CreateAccountView: UIView, UITextFieldDelegate{
    var tapClosure: (() -> Void)?
    
    var passwordTapClosure: (() -> Void)?
    
    var confirmPasswordTapClosure: (() -> Void)?
    
    var resignedResponder: ((UITextField) -> Void)?
    
    lazy var animationView: LOTAnimationView = self.createAnimationView()
    lazy var signUpLabel: UILabel = self.createSignUpLabel()
    
    
    lazy var bottomBorder: CALayer = CALayer()
    lazy var passwordBottomBorder: CALayer = CALayer()
    lazy var confirmPasswordBottomBorder: CALayer = CALayer()
    
    lazy var emailTextView: UIView = self.createEmailTextView()
    lazy var emailStackView: UIStackView = createTextFieldStackView()
    lazy var emailPlaceholderLabel: UILabel = createPlaceholderLabel(withText: "Enter Email")
    lazy var emailTextField: UITextField = createCustomTextField(withView: self, placeholder: "Enter Email", selector: #selector(handleTextFieldTap))
    
    lazy var passwordTextView: UIView = self.createPasswordTextView()
    lazy var passwordStackView: UIStackView = createTextFieldStackView()
    lazy var passwordPlaceholderLabel: UILabel = createPlaceholderLabel(withText: "Enter Password")
    lazy var passwordTextField: UITextField = createCustomTextField(withView: self, placeholder: "Enter Password", selector: #selector(handlePasswordTextFieldTap))
    
    lazy var confirmPasswordTextView: UIView = self.createConfirmPasswordTextView()
    lazy var confirmPasswordStackView: UIStackView = createTextFieldStackView()
    lazy var confirmPasswordPlaceholderLabel: UILabel = createPlaceholderLabel(withText: "Confirm Password")
    lazy var confirmPasswordTextField: UITextField = createCustomTextField(withView: self, placeholder: "Confirm Password", selector: #selector(handleConfirmPasswordTextFieldTap))
    
    
    
    
    lazy var signUpContainer: TouchableBounceView = self.createSignUpContainer()
    
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        layout()
    }
    
    @objc func handleTextFieldTap() {
        self.tapClosure?()
    }
    
    @objc func handlePasswordTextFieldTap() {
        self.passwordTapClosure?()
    }
    
    @objc func handleConfirmPasswordTextFieldTap() {
        self.confirmPasswordTapClosure?()
    }
}


// Factory Extension

extension CreateAccountView {
    
    
    func createAnimationView() -> LOTAnimationView {
        let animationView = LOTAnimationView(name: "office")
        animationView.play()
        return animationView
    }
    
    func createSignUpLabel() -> UILabel {
        
        // MARK: NEW TODO Change font type and font size of label
        let signUpLabel = UILabel()
        
        signUpLabel.text = "Sign Up"
        
        
        signUpLabel.font = UIFont.bold(size: 30)
        
        return signUpLabel
    }
    
    func createEmailTextView() -> UIView {
        let textFieldView = UIView()
        
        
        return textFieldView
    }
    
    func createPasswordTextView() -> UIView {
        let textView = UIView()
        
        return textView
    }
    
    func createConfirmPasswordTextView() -> UIView {
        let textView = UIView()
        return textView
    }
    
//    func createSignUpButton() -> UIButton {
//        let signUpButton = UIButton()
//        signUpButton.setTitle("Sign Up", for: .normal)
//
//        signUpButton.titleLabel?.font = .bold(size: 17)
//        return signUpButton
//    }
    
    func createSignUpContainer() -> TouchableBounceView {
        let container = TouchableBounceView()
        
        let containerView = UIView()
        let label = UILabel()
        
        label.text = "Sign Up"
        label.font = UIFont.bold(size: 13)
        
        container.addSubview(label)
        
        label.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        container.addSubview(containerView)
        
        containerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        return container
    }
}


// Layout Extension
extension CreateAccountView {
    func layout() {
        layoutAnimationView()
        layoutSignUpLabel()
        layoutSignUpContainerView()
        layoutEmailTextView()
        
        layoutPasswordTextView()
        
        layoutConfirmPasswordTextView()
    }
    
    func layoutAnimationView() {
        self.addSubview(self.animationView)
        
        self.animationView.snp.makeConstraints { (make) in
            make.height.equalTo(200)
            
            make.width.equalTo(self.frame.width / 2)
            
            make.topMargin.equalTo(self.safeAreaLayoutGuide.snp.topMargin).offset(10)
            make.right.equalToSuperview().inset(15)
        }
    }
    
    func layoutSignUpLabel() {
        
        // Using labels natural length
        self.addSubview(self.signUpLabel)
        
        self.signUpLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.animationView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
        }
    }
    
    func layoutEmailTextView() {
        
        self.addSubview(self.emailTextView)
        //
        //        // Call layoutStackView
        
        self.layoutEmailStackView()
        
        self.emailTextView.snp.makeConstraints { (make) in
            make.top.equalTo(self.signUpLabel.snp.bottom).offset(20)
            
            make.centerX.equalToSuperview()
            
            make.width.equalToSuperview().inset(20)
        }
        
        createViewBorder(withSuperLayer: self.emailTextView, withBorder: &self.bottomBorder)
    }
    
    func layoutEmailStackView() {
        self.emailTextView.addSubview(self.emailStackView)
        
        self.layoutEmailPlaceholderLabel()
        self.layoutEmailTextField() // Handles the placing and layout inside the email stack view
        
        
        self.emailStackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func layoutEmailTextField() {
        self.emailStackView.addArrangedSubview(self.emailTextField)
        emailTextField.delegate = self
        emailTextField.tag = 1
        
        self.emailTextField.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.top.equalTo(self.emailPlaceholderLabel.snp.bottom)
        }
    }
    
    func layoutEmailPlaceholderLabel() {
        self.emailStackView.addArrangedSubview(self.emailPlaceholderLabel)
        
        self.emailPlaceholderLabel.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
        }
    }
    
    
    func layoutPasswordTextView() {
        
        self.addSubview(self.passwordTextView)
        //
        //        // Call layoutStackView
        
        self.layoutPasswordStackView()
        
        self.passwordTextView.snp.makeConstraints { (make) in
            make.top.equalTo(self.emailTextView.snp.bottom).offset(50)
            
            make.centerX.equalToSuperview()
            
            make.width.equalToSuperview().inset(20)
        }
        
        createViewBorder(withSuperLayer: self.passwordTextView, withBorder: &self.passwordBottomBorder)
    }
    
    func layoutPasswordStackView() {
        self.passwordTextView.addSubview(self.passwordStackView)
        
        self.layoutPasswordPlaceholderLabel()
        self.layoutPasswordTextField() // Handles the placing and layout inside the email stack view
        
        
        self.passwordStackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func layoutPasswordTextField() {
        self.passwordStackView.addArrangedSubview(self.passwordTextField)
        passwordTextField.delegate = self
        passwordTextField.tag = 2
        
        self.passwordTextField.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.top.equalTo(self.passwordPlaceholderLabel.snp.bottom)
        }
    }
    
    func layoutPasswordPlaceholderLabel() {
        self.passwordStackView.addArrangedSubview(self.passwordPlaceholderLabel)
        
        self.passwordPlaceholderLabel.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
        }
    }
    
    func layoutConfirmPasswordTextView() {
        
        self.addSubview(self.confirmPasswordTextView)
        //
        //        // Call layoutStackView
        
        self.layoutConfirmPasswordStackView()
        
        self.confirmPasswordTextView.snp.makeConstraints { (make) in
            make.top.equalTo(self.passwordTextView.snp.bottom).offset(50)
            
            make.centerX.equalToSuperview()
            
            make.width.equalToSuperview().inset(20)
        }
        
        createViewBorder(withSuperLayer: self.confirmPasswordTextView, withBorder: &self.confirmPasswordBottomBorder)
    }
    
    func layoutConfirmPasswordStackView() {
        self.confirmPasswordTextView.addSubview(self.confirmPasswordStackView)
        
        self.layoutConfirmPasswordPlaceholderLabel()
        self.layoutConfirmPasswordTextField() // Handles the placing and layout inside the email stack view
        
        
        self.confirmPasswordStackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func layoutConfirmPasswordTextField() {
        self.confirmPasswordStackView.addArrangedSubview(self.confirmPasswordTextField)
        confirmPasswordTextField.delegate = self
        confirmPasswordTextField.tag = 3
        
        self.confirmPasswordTextField.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.top.equalTo(self.confirmPasswordPlaceholderLabel.snp.bottom)
        }
    }
    
    func layoutConfirmPasswordPlaceholderLabel() {
        self.confirmPasswordStackView.addArrangedSubview(self.confirmPasswordPlaceholderLabel)
        
        self.confirmPasswordPlaceholderLabel.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
        }
    }
    
    func layoutSignUpContainerView() {
        self.addSubview(self.signUpContainer)
        
        self.signUpContainer.snp.makeConstraints { (make) in
            make.width.equalTo(310)
            make.height.equalTo(55)
            
            make.bottom.equalToSuperview().offset(-20)
        }
    }
}

extension CreateAccountView {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case 1:
            self.resignedResponder?(self.emailTextField)
            
            
        case 2:
            self.resignedResponder?(self.passwordTextField)
            
        case 3:
            self.resignedResponder?(self.confirmPasswordTextField)
            
        default:
            self.resignedResponder?(UITextField())
        }
    }
}
