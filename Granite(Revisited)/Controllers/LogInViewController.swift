//
//  LogInViewController.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 4/17/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit
import Lottie

class LogInViewController: UIViewController, UITextFieldDelegate, KeyboardDelegate {
    
    
    let loginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginView.frame = self.view.bounds
        
        self.view.addSubview(loginView)
        
        loginView.addConfiguredView()
        loginView.configureAnimation()
        
        let padding = UIEdgeInsets(top: 0, left: 20, bottom: -50, right: -20)
        
        loginView.whiteLoginView.anchor(top: loginView.configuredView.bottomAnchor, leading: self.view.leadingAnchor , bottom: self.view.bottomAnchor, trailing: self.view.trailingAnchor, padding: padding)
        
        loginView.loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        loginView.createAccountButton.addTarget(self, action: #selector(handleCreateAccount), for: .touchUpInside)
        
        self.navigationController?.title = "Welcome"
//
//        loginView.usernameTextField.returnKeyType = .return
//        loginView.passwordTextField.returnKeyType = .continue
        
        loginView.usernameTextField.delegate = self
        loginView.passwordTextField.delegate = self
        
        
        loginView.keyboardDelegate = self
//
    }
    
    @objc func handleKeyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            guard let keyboardFrame = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? CGRect else {return}
            
            if view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardFrame.height
            }
            
        }
        
        NotificationCenter.default.removeObserver(self, name: UIWindow.keyboardWillShowNotification, object: nil)
    }
    
    @objc func willHideKeyboard(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            guard let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {return}
            
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y = 0
            }
            
        }
        
        NotificationCenter.default.removeObserver(self, name: UIWindow.keyboardWillHideNotification, object: nil)
    }
    
    @objc func handleCreateAccount() {
        // TODO: MARK Handle tap
        let onboardingFlowController = OnboardingController()
        onboardingFlowController.hero.isEnabled = true
        
        onboardingFlowController.hero.modalAnimationType = .fade
        self.present(onboardingFlowController, animated: true, completion: nil)
    }
    
    @objc func handleLogin() {
        guard let username = loginView.usernameTextField.text,
            let password = loginView.passwordTextField.text,
            let user = User(username: username , password: password)
            else {return}
        
        authenticateUser(withUser: user) { (user, err) in
            print(user?.languages, err)
        }
    }
    
    func keyboardIsActive() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIWindow.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willHideKeyboard), name: UIWindow.keyboardWillHideNotification, object: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return false
    }
}

