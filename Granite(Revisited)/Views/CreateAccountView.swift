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
    lazy var emailTextField: UITextField = self.createEmailTextField()
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
        
        signUpLabel.font = UIFont.bold(size: 20)
        
        return signUpLabel
    }
    
    func createEmailTextField() -> UITextField {
        let emailTextField = UITextField()
        emailTextField.placeholder = "Email"
        return emailTextField
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
            make.left.equalToSuperview().offset(10)
        }
    }
    
    func layoutEmailTextField() {
        self.addSubview(self.emailTextField)
        
        self.emailTextField.snp.makeConstraints { (make) in
            make.top.equalTo(self.signUpLabel.snp.bottom).offset(5)
            make.width.equalToSuperview().offset(10)
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
