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
        
        self.emailTextField.keyboardType = .emailAddress
        
        self.githubProfileUsernameTextField = UITextField(frame: frame)
        self.languagesTextField = UITextField(frame: frame)
        
        self.configureTextFields(self.view,textFields: self.emailTextField, self.usernameTextField, self.passwordTextField)
        
        self.emailTextField.placeholder = "Email"
        self.usernameTextField.placeholder = "Username"
        self.passwordTextField.placeholder = "Password"
        
        self.githubProfileUsernameTextField.placeholder = "Github Profile Username"
        self.languagesTextField.placeholder = "Languages"
    }
    
    func configureTextFields(_ view: UIView, textFields: UITextField...) {
        // MARK: FIX Make dynamic for any view and constrain SUPER HARD CODED FOR IPHONE XS
        var distanceCounter = self.view.center.y  - 50
        
        textFields.forEach { (textField) in
            let frame = CGRect(x: self.view.center.x, y: distanceCounter, width: self.view.frame.width / 1.5, height: 50)
            textField.frame = frame
            textField.center = self.view.center
            textField.textAlignment = .center
            
            distanceCounter += 80
            textField.center.y = distanceCounter
            self.view.addSubview(textField)
            textField.borderStyle = .roundedRect
            
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           options: .curveEaseOut, animations: {
                            textField.alpha = 0
                            textField.alpha = 1
                            view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
}
