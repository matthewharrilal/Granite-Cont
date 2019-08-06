//
//  ThirdOnboardingController.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 8/6/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit

class ThirdOnboardingController: UIViewController {
    lazy var thirdOnboardingScreen = ThirdOnboardingScreen()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.restorationIdentifier = NSStringFromClass(self.classForCoder)
        self.view.backgroundColor = .white
    }
    
    override func viewDidLayoutSubviews() {
        layout()
    }
}

extension ThirdOnboardingController {
    func layout() {
        layoutThirdOnboardingScreen()
    }
    
    func layoutThirdOnboardingScreen() {
        self.view.addSubview(self.thirdOnboardingScreen)
        
    }
}
