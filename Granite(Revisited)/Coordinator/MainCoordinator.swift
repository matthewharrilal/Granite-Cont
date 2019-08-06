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

    func createAccountView() {
        let createAccountViewController = CreateAccountViewController()
        createAccountViewController.coordinator = self
        
        self.navigationController.pushViewController(createAccountViewController, animated: true)
    }
    
    func startOnboardingFlow(name: String) {
        let onboardingController = OnboardingViewController()
//        onboardingController.coordinator = self
//
//        onboardingController.firstName = name

        
        
        self.navigationController.pushViewController(onboardingController, animated: true)
    }
    
    func showSecondOnboardingScreen() {
        // Instantiate Second Onboard Screen Controller
        let secondOnboardingController = SecondOnboardingController()
        secondOnboardingController.hero.isEnabled = true
        secondOnboardingController.hero.modalAnimationType = .cover(direction: .up)
        
//        let transition = CATransition()
//        transition.duration = 0.5
//        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
//        transition.type = .moveIn
//        transition.subtype = .fromTop
//        self.navigationController.view.layer.add(transition, forKey: kCATransition)
        self.navigationController.present(secondOnboardingController, animated: true)
//        self.navigationController.pushViewController(secondOnboardingController, animated: true)
    }
}


// Factory Extension

extension MainCoordinator {
    func createLoginViewController() -> LogInViewController {
        let loginViewController = LogInViewController()
        
        return loginViewController
    }
}
