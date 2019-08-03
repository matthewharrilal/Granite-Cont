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
        layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}


// Factory Extension

extension CreateAccountView {
    
    func createAnimationView() -> LOTAnimationView {
        let animationView = LOTAnimationView(name: "office")
        return animationView
    }
    
    func createSignUpLabel() -> UILabel {
        let signUpLabel = UILabel()
        
        signUpLabel.text = "Sign Up"
        
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
        
    }
}
