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

class LogInViewController: UIViewController {
    
    let loginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginView.frame = self.view.bounds
        
        self.view.addSubview(loginView)
        
        loginView.addConfiguredView()
        loginView.configureAnimation()
        loginView.configureLockAnimation()
        
        let padding = UIEdgeInsets(top: -100, left: 20, bottom: -50, right: -20)
        
        loginView.whiteLoginView.anchor(top: loginView.configuredView.bottomAnchor, leading: self.view.leadingAnchor , bottom: self.view.bottomAnchor, trailing: self.view.trailingAnchor, padding: padding)
        
        loginView.loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        loginView.createAccountButton.addTarget(self, action: #selector(handleCreateAccount), for: .touchUpInside)
    }
    
    @objc func handleCreateAccount() {
        // TODO: MARK Handle tap
        let onboardingFlowController = OnboardingFlow()
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
}

