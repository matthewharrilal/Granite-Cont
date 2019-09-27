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

class LogInViewController: UIViewController, UITextFieldDelegate {
    
    
    let loginView = LoginView()
    
    var coordinator: MainCoordinator?
    
    
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginView.frame = self.view.bounds
        
        self.view.addSubview(loginView)
        
        loginView.addConfiguredView()
        loginView.configureAnimation()
        
        let padding = UIEdgeInsets(top: 0, left: 20, bottom: -50, right: -20)
        
        loginView.whiteLoginView.anchor(top: loginView.configuredView.bottomAnchor, leading: self.view.leadingAnchor , bottom: self.view.bottomAnchor, trailing: self.view.trailingAnchor, padding: padding)
        
        
        self.navigationController?.title = "Welcome"
        //
        //        loginView.usernameTextField.returnKeyType = .return
        //        loginView.passwordTextField.returnKeyType = .continue
        
        loginView.usernameTextField.delegate = self
        loginView.passwordTextField.delegate = self
        
        
        
        loginView.createAccountTapClosure = {[unowned self] in
            self.coordinator?.createAccountView()
        }
        
        loginView.loginTapClosure = {[unowned self] in
            self.handleLogin()
        }
        //
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

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        self.count = 0
        return false
    }
}

