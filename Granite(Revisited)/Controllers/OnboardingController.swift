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
    var secondOnboardingScreen: SecondOnboardingScreen!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstOnboardingScreen = FirstOnboardingScreen(frame: self.view.frame)
        secondOnboardingScreen = SecondOnboardingScreen(frame: self.view.frame)

        firstOnboardingScreen.bounds = firstOnboardingScreen.frame
        self.view.addSubview(firstOnboardingScreen)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        firstOnboardingScreen.createTransitionButton()
        firstOnboardingScreen.animateLabels()
        firstOnboardingScreen.transitionButton.addTarget(self, action: #selector(handleTap(sender:)), for: .touchUpInside)
    }
}
