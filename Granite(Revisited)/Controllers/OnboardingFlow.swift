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
    
    var usernameTextField: UITextField!
    
    var passwordTextField: UITextField!
    
    let onboardingView = PaperOnboarding()
    
    var onboardingInfoItems: [OnboardingItemInfo]?
    
    var manager: UndoManager?
    
    
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
        configureUsernameField()
        configurePasswordField()
    }
    
    func onboardingItemsCount() -> Int {
        return 2
    }
    
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        let titleFont = UIFont(name: "AvenirNext-Bold", size: 24)!
        let descirptionFont = UIFont(name: "AvenirNext-Regular", size: 18)!
        let image = UIImage(imageLiteralResourceName: "lorem.jpg")
        self.onboardingInfoItems =  [
            OnboardingItemInfo(informationImage: image, title: "", description: "", pageIcon: image, color: UIColor(hexString: "c9ddff"), titleColor: .red, descriptionColor: .orange, titleFont: titleFont, descriptionFont: descirptionFont),
            OnboardingItemInfo(informationImage: image, title: "", description: "", pageIcon: image, color: UIColor(hexString: "ff9b71"), titleColor: .red, descriptionColor: .orange, titleFont: titleFont, descriptionFont: descirptionFont)
        ]
        
        return self.onboardingInfoItems![index] as OnboardingItemInfo
    }
    
    func onboardingWillTransitonToIndex(_ index : Int) {
        guard let currentItem = self.onboardingInfoItems?[index] as? OnboardingItemInfo else {return}
        
        
        switch index {
        case 0:
            self.emailTextField.placeholder = "Email"
            self.usernameTextField.placeholder = "Username"
            self.passwordTextField.isHidden = false
            
        case 1:
            self.emailTextField.placeholder = "Github Profile Username"
            self.usernameTextField.placeholder = "Languages"
            self.passwordTextField.isHidden = true
        default:
            self.emailTextField.placeholder = ""
        }
        
    }
    
    func configureFields() {
        let frame = CGRect(x: self.view.center.x, y: self.view.center.y, width: 150, height: 50)
        self.emailTextField = UITextField(frame: frame)
        self.emailTextField.center = self.view.center
        
        self.emailTextField.center.y += 100
        self.emailTextField.placeholder = "Email"
        self.onboardingView.addSubview(self.emailTextField)
        self.emailTextField.borderStyle = .roundedRect
        
        guard let undoManager = manager else {return}
        
        self.emailTextField.isEnabled = undoManager.canUndo
        self.emailTextField.isEnabled = undoManager.canRedo
        
    }
    
    func configureUsernameField() {
        let frame = CGRect(x: self.view.center.x, y: self.view.center.y, width: 150, height: 50)
        self.usernameTextField = UITextField(frame: frame)
        self.usernameTextField.center = self.view.center
        
        self.usernameTextField.center.y += 180
        self.usernameTextField.placeholder = "Username"
        self.onboardingView.addSubview(self.usernameTextField)
        self.usernameTextField.borderStyle = .roundedRect
    }
    
    func configurePasswordField() {
        let frame = CGRect(x: self.view.center.x, y: self.view.center.y, width: 150, height: 50)
        self.passwordTextField = UITextField(frame: frame)
        self.passwordTextField.center = self.view.center
        
        self.passwordTextField.center.y += 260
        self.passwordTextField.placeholder = "Password"
        self.onboardingView.addSubview(self.passwordTextField)
        self.passwordTextField.borderStyle = .roundedRect
    }
    
}
