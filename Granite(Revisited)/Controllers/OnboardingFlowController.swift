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
    
    var user: User?
    
    var githubProfileUsernameTextField: UITextField!
    
    var languagesTextField: UITextField!
    
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
        
        // In charge of configuring initial fields
        configureFields()
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
        switch index {
        case 0:
            configureTextFields(textFields: self.emailTextField, self.usernameTextField, self.passwordTextField)
            self.emailTextField.placeholder = "Email"
            self.usernameTextField.placeholder = "Username"
            self.passwordTextField.isHidden = false
            
            
        case 1:
            configureTextFields(textFields: self.githubProfileUsernameTextField, self.languagesTextField)
            self.passwordTextField.isHidden = true
            self.githubProfileUsernameTextField.placeholder = "Github Profile Username"
            self.languagesTextField.placeholder = "Languages"
            
            
        default:
            break
        }
        
        print(user?.languages)
    }
    
    func onboardingDidTransitonToIndex(_ index: Int) {
        
        guard let email = self.emailTextField.text,
            let username = self.usernameTextField.text,
            let password = self.passwordTextField.text,
            let githubUsername = self.githubProfileUsernameTextField.text,
            let languages = self.languagesTextField.text
            else {return}
        
        switch index {
        case 1:
            // MARK: TODO Error handling for empty text attributes
            self.user = User(email: email, password: password)
            user?.username = username
            
            // After transitioning to corresponding index clear text fields
            clearTextFields(textFields: emailTextField, usernameTextField, passwordTextField)
            
        case 0:
            user?.languages = languages.components(separatedBy: ",")
            user?.githubProfileUsername = githubUsername
            
            clearTextFields(textFields: githubProfileUsernameTextField, languagesTextField)
        default:
            break
        }
    }
    
    func clearTextFields(textFields: UITextField...) {
        textFields.forEach { (textField) in
            textField.text = ""
        }
    }
    
}


