//
//  CreateAccountViewControllerr.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 8/3/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit


class CreateAccountViewController: UIViewController {
    
    lazy var accountView: CreateAccountView = self.createAccountView()
    weak var coordinator: MainCoordinator?
    var user: User!
    
    var keyboardTapClosure: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        
        self.accountView.fullNameTapClosure = {[weak self] in
            self?.animateFullNameTextView()
            // Handle keyboard tap
            
            self?.keyboardTapClosure?()
        }
        
        self.accountView.tapClosure = {[weak self] in
            self?.animateEmailView()
            self?.keyboardTapClosure?()
        }
        
        self.accountView.passwordTapClosure = {[weak self] in
            self?.animatePasswordView()
            self?.keyboardTapClosure?()
        }
        
        self.accountView.confirmPasswordTapClosure = {[weak self] in
            self?.animateConfirmPasswordView()
            self?.keyboardTapClosure?()
        }
        
        self.accountView.resignedResponder = {[unowned self] textField in

            switch textField.tag {
                
            case 0:
                resetViewBorder(withBorder: &self.accountView.fullNameBottomBorder)
            case 1:
                
                resetViewBorder(withBorder: &self.accountView.bottomBorder)
                
            case 2:
                resetViewBorder(withBorder: &self.accountView.passwordBottomBorder)
                
            case 3:
                resetViewBorder(withBorder: &self.accountView.confirmPasswordBottomBorder)
                
            default:
                return
            }
        }
        
        
        self.keyboardTapClosure = {[unowned self] in
            print("Keyboard is active")
            NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIWindow.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(willHideKeyboard), name: UIWindow.keyboardWillHideNotification, object: nil)
        }
        
        self.accountView.signUpContainer.selectBlock = {[unowned self] in
            
            // Need to pass the first name so that we can start the onboarding flow
            if let fullName = self.accountView.fullNameTextField.text {
                let firstName = fullName.components(separatedBy: " ")
                self.setUserInformation(fullName: fullName)
                self.coordinator?.startOnboardingFlow(name: firstName[0])
            }
            
        }
    }
    
    @objc func handleKeyboardNotification() {}
    
    @objc func willHideKeyboard() {}
    
    func setUserInformation(fullName: String) {
        // This is at a point in time where the user has filled in all the required text fields therefore we can start populating the user object that is going to be passed through the onboarding flow
        
        // MARK: TODO FIX Add confirm password and password matching logic
        
        guard let password = self.accountView.passwordTextField.text else {return}
        
        self.user = User(email: fullName , username: fullName, password: password)
        
        self.coordinator?.setCommunicatedUser(withUser: user)
        // Now the question is how does the first onboarding screen in the onboarding flow get access to this user object
        
    }
    
    func animateFullNameTextView() {
        UIView.animate(withDuration: 0.5) {
            self.accountView.fullNameTextField.placeholder = ""
            self.accountView.fullNamePlaceHolderLabel.alpha = 0.8
            
            animateViewBorder(withHexColor: "8CDFD6", withBorder: &self.accountView.fullNameBottomBorder)
        }
    }
    
    func animateEmailView() {
        UIView.animate(withDuration: 0.5) {
            self.accountView.emailTextField.placeholder = ""
            self.accountView.emailPlaceholderLabel.alpha = 0.8
            
            animateViewBorder(withHexColor: "8CDFD6", withBorder: &self.accountView.bottomBorder)
        }
    }
    
    func animatePasswordView() {
        UIView.animate(withDuration: 0.5) {
            self.accountView.passwordTextField.placeholder = ""
            self.accountView.passwordPlaceholderLabel.alpha = 0.8
            
            animateViewBorder(withHexColor: "8CDFD6", withBorder: &self.accountView.passwordBottomBorder)
        }
    }
    
    func animateConfirmPasswordView() {
        UIView.animate(withDuration: 0.5) {
            self.accountView.confirmPasswordTextField.placeholder = ""
            self.accountView.confirmPasswordPlaceholderLabel.alpha = 0.8
            
            animateViewBorder(withHexColor: "8CDFD6", withBorder: &self.accountView.confirmPasswordBottomBorder)
        }
    }
    
}

// Factory Extension
extension CreateAccountViewController {
    func createAccountView() -> CreateAccountView {
        let createAccountView = CreateAccountView()
        createAccountView.backgroundColor = UIColor(hexString: "ccddfc")
        
        //        createAccountView.emailTextField.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        
        return createAccountView
    }
    
    
}

// Layout Extension
extension CreateAccountViewController {
    func layout() {
        self.view.backgroundColor = .white
        layoutAccountView()
        
    }
    
    func layoutAccountView() {
        self.view.addSubview(self.accountView)
        
        accountView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}


