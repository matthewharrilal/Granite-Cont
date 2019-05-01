//
//  OnboardingFlow.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 5/1/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit
import paper_onboarding

class OnboardingFlow: UIViewController, PaperOnboardingDelegate, PaperOnboardingDataSource {
    
    var emailTextField: UITextField!
    
    let onboardingView = PaperOnboarding()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onboardingView.dataSource = self
        onboardingView.delegate = self
        self.view.addSubview(onboardingView)
        
        // add constraints
        for attribute: NSLayoutConstraint.Attribute in [.left, .right, .top, .bottom] {
            let constraint = NSLayoutConstraint(item: onboardingView,
                                                attribute: attribute,
                                                relatedBy: .equal,
                                                toItem: view,
                                                attribute: attribute,
                                                multiplier: 1,
                                                constant: 0)
            view.addConstraint(constraint)
        }
        
        configureFields()
    }
    
    func onboardingItemsCount() -> Int {
        return 2
    }
    
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        let titleFont = UIFont(name: "AvenirNext-Bold", size: 24)!
        let descirptionFont = UIFont(name: "AvenirNext-Regular", size: 18)!
        let image = UIImage(imageLiteralResourceName: "lorem.jpg")
        return [
            OnboardingItemInfo(informationImage: image, title: "", description: "", pageIcon: image, color: .blue, titleColor: .red, descriptionColor: .orange, titleFont: titleFont, descriptionFont: descirptionFont),
            OnboardingItemInfo(informationImage: image, title: "", description: "", pageIcon: image, color: .white, titleColor: .red, descriptionColor: .orange, titleFont: titleFont, descriptionFont: descirptionFont)
            ][index] as OnboardingItemInfo
    }
    
    func onboardingConfigurationItem(item: OnboardingContentViewItem, index _: Int) {
        
    }
    
    func configureFields() {
        let frame = CGRect(x: self.view.center.x, y: self.view.center.y, width: 150, height: 50)
        self.emailTextField = UITextField(frame: frame)
        self.emailTextField.center = self.view.center
        
        self.emailTextField.center.y += 200
        self.emailTextField.placeholder = "Email"
        self.onboardingView.addSubview(self.emailTextField)
        self.emailTextField.borderStyle = .roundedRect
        
    }
}
