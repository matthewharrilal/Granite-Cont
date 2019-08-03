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
    var childCoordinators: [Coordinator] = [Coordinator]()
    
    var navigationController: UINavigationController
    
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController // Every coordinator manages their hierarchal stack via their own navigation controllers
    }
    
    
    func start() {
        // Initial View Controller
        
        let loginViewController = LogInViewController()
        self.navigationController.pushViewController(loginViewController, animated: true)
    }
}
