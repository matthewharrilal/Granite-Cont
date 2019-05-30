//
//  SecondOnboardingController.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 5/30/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit

class SecondOnboardingController: UIViewController {
    // In charge of handling transition buttons tap
    lazy var secondOnboardingScreen = SecondOnboardingScreen()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @objc func handleTap() {
        print(secondOnboardingScreen.languageSet)
    }
}
