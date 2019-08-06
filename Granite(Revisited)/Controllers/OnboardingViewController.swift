//
//  TestViewController.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 8/5/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit

class OnboardingViewController: UIViewController {
    // Used to test the embedding of a page view controller
    
    lazy var pageViewController = OnboardingPageViewController()
    lazy var transitionButton: TouchableBounceView = createTouchableBounceButton(withText: "Next")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addChild(pageViewController)
        
        self.view.addSubview(self.pageViewController.view)
        
        self.view.backgroundColor = .white
        
    }
    
    override func viewDidLayoutSubviews() {
        
        let height = self.view.bounds.height
        self.pageViewController.view.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(height * 0.8)
            
        }
        
        layoutTransitionButton()
        transformTouchableBounceView(withBounceView: self.transitionButton)
    }
    
    
    func layoutTransitionButton() {
        self.view.addSubview(transitionButton)
        
        let differenceInHeight = self.view.bounds.height - (self.view.bounds.height * 0.8)
        
        self.transitionButton.backgroundColor = .init(hexString: "317AC1")
        
        self.transitionButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.pageViewController.view.snp.bottom).offset(differenceInHeight / 3)
            
            make.height.equalTo(65)
            make.width.equalTo(300)
//            make.bottom.equalToSuperview().offset(-(differenceInHeight))
        }
    }
}

// HOW THE NEW FLOW WILL GO IS THAT THIS SCREEN CONTAINS THE TRANSITION BUTTON AND EACH ONBOARDING PAGE IS HANDLED BY THE PAGE VIEW CONTROLLER WHICH IS CREATED HERE THEREFORE THIS NAME SHOULD BE ONBOARDING CONTROLLER

// ONBOARDING CONTROLLER SHOULD BE RENAMED TO FIRSTONBOARDINGCONTROLLER due it only having knowledge of the first onboarding screen
