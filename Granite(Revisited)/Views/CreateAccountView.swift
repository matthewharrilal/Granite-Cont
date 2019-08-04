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

class CreateAccountView: UIView {
    lazy var animationView: LOTAnimationView = self.createAnimationView()
    lazy var signUpLabel: UILabel = self.createSignUpLabel()
    var bottomBorder: CALayer = CALayer()
    
    lazy var emailTextField: UITextField = self.createEmailTextField()
    lazy var emailTextView: UIView = self.createEmailTextView()
    lazy var emailPlaceholderLabel: UILabel = self.createEmailPlaceholderLabel()
    lazy var emailStackView: UIStackView = self.createEmailStackView()
    
    lazy var signUpButton: UIButton = self.createSignUpButton()
    
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        layout()
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
        
        
        UIFont.familyNames.forEach { (name) in
            let fontName = UIFont.fontNames(forFamilyName: name)
            
            print(name, fontName)
        }
        
        signUpLabel.font = UIFont.bold(size: 30)
        
        return signUpLabel
    }
    
    func createEmailTextView() -> UIView {
        let textFieldView = UIView()
        
        
        return textFieldView
    }
    
    func createEmailPlaceholderLabel() -> UILabel {
        let emailPlaceholderLabel = UILabel()
        emailPlaceholderLabel.text = "Enter email"
        
        emailPlaceholderLabel.font = .regular(size: 13)
        
        return emailPlaceholderLabel
    }
    
    func createEmailTextField() -> UITextField {
        let emailTextField = UITextField()
        emailTextField.placeholder = "Email"
        
        emailTextField.borderStyle = .none
        
        emailTextField.layer.borderColor = UIColor.init(hexString: "8CDFD6").cgColor
        return emailTextField
    }
    
    func createEmailStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 5
        
        return stackView
    }
    
    func createSignUpButton() -> UIButton {
        let signUpButton = UIButton()
        signUpButton.setTitle("Sign Up", for: .normal)
        return signUpButton
    }
}


// Layout Extension
extension CreateAccountView {
    func layout() {
        layoutAnimationView()
        layoutSignUpLabel()
        layoutEmailTextField()
        layoutSignUpButton()
        layoutTextView()
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
    
    func layoutTextView() {
        
        self.addSubview(self.emailTextView)
        //
        //        // Call layoutStackView
        
        self.layoutEmailStackView()
        
        self.emailTextView.snp.makeConstraints { (make) in
            make.top.equalTo(self.signUpLabel.snp.bottom).offset(20)
            
            make.centerX.equalToSuperview()
            
            make.width.equalToSuperview().inset(20)
        }
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
        
        self.emailTextField.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
        }
    }
    
    func layoutEmailPlaceholderLabel() {
        self.emailStackView.addArrangedSubview(self.emailPlaceholderLabel)
        
        self.emailPlaceholderLabel.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(self.emailTextField.snp.top)
        }
    }
    
    func layoutSignUpButton() {
        self.addSubview(self.signUpButton)
        
        self.signUpButton.snp.makeConstraints { (make) in
            make.width.equalTo(310)
            make.height.equalTo(55)
            
            make.bottom.equalToSuperview().offset(-20)
        }
    }
}
