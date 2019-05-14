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
    
    var pulsatingLayer = CAShapeLayer()
    
    var shapeLayer = CAShapeLayer()
    
    
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
            configureTextFields(self.view,textFields: self.emailTextField, self.usernameTextField, self.passwordTextField)
            
            self.passwordTextField.isHidden = false
            
            self.onboardingView.pageView?.isHidden = false
            
            self.shapeLayer.removeFromSuperlayer()
            self.pulsatingLayer.removeFromSuperlayer()
            
        case 1:
            configureTextFields(self.view,textFields: self.githubProfileUsernameTextField, self.languagesTextField)
            
            self.passwordTextField.isHidden = true
            
            // MARK: TODO Add Create User Button
            self.onboardingView.pageView?.isHidden = true
            (shapeLayer, pulsatingLayer) = configureEnterButton(withPulsatingLayer: &self.pulsatingLayer, withShapeLayer: &self.shapeLayer, onView: self.view)
            
        default:
            break
        }
        
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
            self.user = User(username: username, password: password)
            user?.email = email
            
            // After transitioning to corresponding index clear text fields
            clearTextFields(textFields: emailTextField, usernameTextField, passwordTextField)
            
            
        case 0:
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        
        guard let point = touch?.location(in: self.view) else {return}
        
        let convertedPoint = self.view.layer.convert(point, to: self.shapeLayer)
        
        // Have to check if the path of the shape layer contains the point not the shape layer itself
        if let path = self.shapeLayer.path, path.contains(convertedPoint) {
            
            guard let githubProfileUsername = self.githubProfileUsernameTextField.text,
                let languages = self.languagesTextField.text
                else {return}
            
            self.user?.githubProfileUsername = githubProfileUsername
            self.user?.languages = languages.components(separatedBy: ",")
            createUser(withUser: self.user) { (user, err) in
                
            }
        }
    }
    
}


