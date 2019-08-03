//
//  MainCoordinator.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 8/3/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = [Coordinator]() // If you need to handle the main coordinators children
    
    lazy var loginViewController: LogInViewController = self.createLoginViewController()
    
    var navigationController: UINavigationController
    
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController // Every coordinator manages their hierarchal stack via their own navigation controllers
    }
    
    
    func start() {
        // Initial View Controller
        self.loginViewController.coordinator = self
        self.navigationController.pushViewController(self.loginViewController, animated: true)
    }
    
    
    // MARK: TODO Handle the transition of DO NOT HAVE AN ACCOUNT -> First onboarding screen
    
    func createAccount() {
        let onboardingController = OnboardingController()
        
        
        
        self.navigationController.pushViewController(onboardingController, animated: true)
    }
    
    func createAccountView() {
        let createAccountViewController = CreateAccountViewController()
        
        
        self.navigationController.pushViewController(createAccountViewController, animated: true)
    }
}


// Factory Extension

extension MainCoordinator {
    func createLoginViewController() -> LogInViewController {
        let loginViewController = LogInViewController()
        
        return loginViewController
    }
}
