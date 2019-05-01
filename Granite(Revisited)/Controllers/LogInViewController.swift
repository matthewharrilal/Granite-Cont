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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginView = LoginView()
        
        loginView.frame = self.view.bounds
        
        self.view.addSubview(loginView)
        
        
        loginView.addConfiguredView()
        loginView.configureAnimation()
        loginView.configureLockAnimation()
        
        loginView.createAccountButton.addTarget(self, action: #selector(handleCreateAccount), for: .touchUpInside)
    }
    
    @objc func handleCreateAccount() {
        // TODO: MARK Handle tap
        let onboardingFlowController = OnboardingFlow()
        onboardingFlowController.hero.isEnabled = true
        
        onboardingFlowController.hero.modalAnimationType = .fade
        self.present(onboardingFlowController, animated: true, completion: nil)
    }
}

