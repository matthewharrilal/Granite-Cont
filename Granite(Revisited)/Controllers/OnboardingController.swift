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
    
    @objc func handleTap(sender: UIButton ) {
        print("Transition Button Being Tapped")
        
        // MARK: TODO Make this view the next onboarding screen and EACH VIEW WILL HAVE ITS OWN HANDLE TAP METHOD
        secondOnboardingScreen = SecondOnboardingScreen(frame: self.view.bounds)
        
        // MARK: TODO Add the next pair of custom views
        secondOnboardingScreen.backgroundColor = .white
        secondOnboardingScreen.alpha = 0.0
        self.view.addSubview(secondOnboardingScreen)
        
        
        // MARK
        UIView.animateKeyframes(withDuration: 2.5, delay: 0.0, options: .calculationModeCubic, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1, animations: {
                self.firstOnboardingScreen.welcomeLabel.alpha = 0.0
                self.firstOnboardingScreen.descriptionLabel.alpha = 0.0
                self.firstOnboardingScreen.animationView.alpha = 0.0
                
                //                self.transitionButton.layer.removeAllAnimations()
                
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5, animations: {
                self.firstOnboardingScreen.transitionButton.alpha = 0.0
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                self.firstOnboardingScreen.transformViews(views: self.firstOnboardingScreen.welcomeLabel, self.firstOnboardingScreen.descriptionLabel, self.firstOnboardingScreen.animationView)
            })
            
            UIView.addKeyframe(withRelativeStartTime: 1.5, relativeDuration: 1, animations: {
                self.secondOnboardingScreen.alpha = 1.0
            })
            
        }) { (_) in
            self.firstOnboardingScreen.removeChildViews(views: self.firstOnboardingScreen.welcomeLabel, self.firstOnboardingScreen.descriptionLabel, self.firstOnboardingScreen.transitionButton)
            
            
            self.secondOnboardingScreen.addSubview(self.firstOnboardingScreen.transitionButton)
            
            
            UIView.animate(withDuration: 1.0, animations: {
                self.firstOnboardingScreen.transitionButton.alpha = 1.0
            })
        }
        
    }
}
