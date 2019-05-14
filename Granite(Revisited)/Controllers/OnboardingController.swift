//
//  OnboardingController.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 5/14/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit

class OnboardingController: UIViewController {
    
    var firstOnboardingScreen: FirstOnboardingScreen!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstOnboardingScreen = FirstOnboardingScreen(frame: self.view.frame)
        self.view.addSubview(firstOnboardingScreen)
        
//        self.view.backgroundColor = .red
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        firstOnboardingScreen.animateLabels()
    }
}
