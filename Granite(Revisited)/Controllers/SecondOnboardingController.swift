//
//  SecondOnboardingController.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 5/28/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit

class SecondOnboardingController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let secondOnboardingScreen = SecondOnboardingScreen(frame: self.view.bounds)
        self.view.addSubview(secondOnboardingScreen)
    }
}
