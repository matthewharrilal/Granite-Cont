//
//  OnboardingViewController+Extension.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 5/1/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit

extension OnboardingFlow {
    
    func configureFields() {
        let frame = CGRect(x: self.view.center.x, y: self.view.center.y, width: 150, height: 50)
        self.emailTextField = UITextField(frame: frame)
        self.usernameTextField = UITextField(frame: frame)
        self.passwordTextField = UITextField(frame: frame)
        
        self.configureTextFields(textFields: self.emailTextField, self.usernameTextField, self.passwordTextField)
        
        self.emailTextField.placeholder = "Email"
        self.usernameTextField.placeholder = "Username"
        self.passwordTextField.placeholder = "Password"
    }
    
    func configureTextFields(textFields: UITextField...) {
        var distanceCounter = self.view.center.y
        textFields.forEach { (textField) in
            let frame = CGRect(x: self.view.center.x, y: self.view.center.y, width: 150, height: 50)
            textField.frame = frame
            textField.center = self.view.center
            distanceCounter += 80
            textField.center.y = distanceCounter
            self.view.addSubview(textField)
            textField.borderStyle = .roundedRect
        }
    }
}
