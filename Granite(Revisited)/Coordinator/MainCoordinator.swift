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
    
    var communicatedUser: User? {
        didSet {
            print("START OF COMMUNICATED USER")
            print("")
            print(communicatedUser?.email)
            print(communicatedUser?.password)
            print(communicatedUser?.languages)
            print(communicatedUser?.mediumProfileUsername)
            print(communicatedUser?.linkedInProfileUsername)
            print(communicatedUser?.githubProfileUsername)
            print("End of the user")
        }
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController // Every coordinator manages their hierarchal stack via their own navigation controllers
    }
    
    
    func start() {
        // Initial View Controller
        self.loginViewController.coordinator = self
        self.navigationController.pushViewController(self.loginViewController, animated: true)
    }
    
    // Pieces the first bits of information of the user
    func setCommunicatedUser(withUser user: User) {
        self.communicatedUser = user
        // Once we have the user then what ... the next screen that gets created we then pass that to the property made there
    }
    
    func saveUser() {
        createUser(withUser: self.communicatedUser) { (user, errror) in
            print(user, errror)
        }
    }
    
    // MARK: TODO Handle the transition of DO NOT HAVE AN ACCOUNT -> First onboarding screen
    
    func createAccountView() {
        let createAccountViewController = CreateAccountViewController()
        createAccountViewController.coordinator = self
        self.navigationController.pushViewController(createAccountViewController, animated: true)
    }
    
    func startOnboardingFlow(name: String) {
        guard let user = self.communicatedUser else {return}
        let onboardingController = OnboardingViewController()
        onboardingController.coordinator = self
        onboardingController.user = user
        
        self.navigationController.pushViewController(onboardingController, animated: true)
    }
    
    func animateTransitionView() {
        let onboardingController = OnboardingViewController()
        UIView.animate(withDuration: 0.75) {
            onboardingController.transitionButton.alpha  = 0.0
        }
        
    }
    
    func showSecondOnboardingScreen() {
        // Instantiate Second Onboard Screen Controller
        let secondOnboardingController = SecondOnboardingController()
        secondOnboardingController.hero.isEnabled = true
        secondOnboardingController.hero.modalAnimationType = .cover(direction: .up)
        
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
