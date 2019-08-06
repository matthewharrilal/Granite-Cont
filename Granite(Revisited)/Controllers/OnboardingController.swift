//
//  OnboardingController.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 5/14/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class OnboardingController: UIViewController {
    
    var firstOnboardingScreen: FirstOnboardingScreen!
    var secondOnboardingScreen: SecondOnboardingScreen!
    var firstName: String?
    
    weak var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.restorationIdentifier = NSStringFromClass(self.classForCoder)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        firstOnboardingScreen = FirstOnboardingScreen(frame: self.view.frame)
        secondOnboardingScreen = SecondOnboardingScreen(frame: self.view.frame)
        
        firstOnboardingScreen.welcomeLabel.text = "Welcome, \(self.firstName ?? "Hacker")"
        
        firstOnboardingScreen.bounds = firstOnboardingScreen.frame
        self.view.addSubview(firstOnboardingScreen)
        
        firstOnboardingScreen.animateLabels()
//        firstOnboardingScreen.transitionButton.addTarget(self, action: #selector(handleTap(sender:)), for: .touchUpInside)
        
        firstOnboardingScreen.transitionButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:))))
        
//        transformTouchableBounceView(withBounceView: firstOnboardingScreen.transitionButton)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        
    }
    
    @objc func handleTap(sender: UIButton) {
        // MARK: TODO Should only handle the change of visual elements and ship to coordinator pattern for second onboarding screen to handle
        UIView.animateKeyframes(withDuration: 2.5, delay: 0.0, options: .calculationModeCubic, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1, animations: {
                
                self.firstOnboardingScreen.welcomeLabel.alpha = 0.0
                self.firstOnboardingScreen.descriptionLabel.alpha = 0.0
                self.firstOnboardingScreen.animationView.alpha = 0.0
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5, animations: {
                self.firstOnboardingScreen.transitionButton.alpha = 0.0
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                self.firstOnboardingScreen.transformViews(views: self.firstOnboardingScreen.welcomeLabel, self.firstOnboardingScreen.descriptionLabel, self.firstOnboardingScreen.animationView)
            })
        }) { (_) in
            self.coordinator?.showSecondOnboardingScreen()
        }
        
        
    }
    
    //    @objc func handleTap(sender: UIButton ) {
    //        print("Transition Button Being Tapped")
    //
    //        // MARK: TODO Make this view the next onboarding screen and EACH VIEW WILL HAVE ITS OWN HANDLE TAP METHOD
    //        secondOnboardingScreen = SecondOnboardingScreen(frame: self.view.bounds)
    //
    //        // MARK: TODO Add the next pair of custom views
    //        secondOnboardingScreen.backgroundColor = .white
    //        secondOnboardingScreen.alpha = 0.0
    //        self.view.addSubview(secondOnboardingScreen)
    //
    //
    //
    //        // MARK
    //        UIView.animateKeyframes(withDuration: 2.5, delay: 0.0, options: .calculationModeCubic, animations: {
    //            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1, animations: {
    //                self.firstOnboardingScreen.welcomeLabel.alpha = 0.0
    //                self.firstOnboardingScreen.descriptionLabel.alpha = 0.0
    //                self.firstOnboardingScreen.animationView.alpha = 0.0
    //
    //                //                self.transitionButton.layer.removeAllAnimations()
    //
    //            })
    //
    //            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5, animations: {
    //                self.firstOnboardingScreen.transitionButton.alpha = 0.0
    //            })
    //
    //            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
    //                self.firstOnboardingScreen.transformViews(views: self.firstOnboardingScreen.welcomeLabel, self.firstOnboardingScreen.descriptionLabel, self.firstOnboardingScreen.animationView)
    //            })
    //
    //            UIView.addKeyframe(withRelativeStartTime: 1.5, relativeDuration: 1, animations: {
    //                self.secondOnboardingScreen.alpha = 1.0
    //            })
    //
    //        }) { (_) in
    //            removeChildViews(views: self.firstOnboardingScreen.welcomeLabel, self.firstOnboardingScreen.descriptionLabel, self.firstOnboardingScreen.transitionButton)
    //
    //            applyTransformation(withButton: self.secondOnboardingScreen.transitionButton)
    //
    //            UIView.animate(withDuration: 1.0, animations: {
    //                self.secondOnboardingScreen.preferredLanguageLabel.alpha = 1.0
    //                self.secondOnboardingScreen.descriptionLabel.alpha = 1.0
    //                self.secondOnboardingScreen.collectionView.alpha = 1.0
    //                self.secondOnboardingScreen.transitionButton.alpha = 1.0
    //            })
    //        }
    //
    //    }
}
