//
//  TestViewController.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 8/5/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit
import KeychainSwift
import IQKeyboardManagerSwift

class OnboardingViewController: UIViewController, UIPageViewControllerDelegate {
    // Used to test the embedding of a page view controller
    
    //    var pageViewController = OnboardingPageViewController()
    lazy var pageViewController: OnboardingPageViewController = self.createOnboardingPageViewController()
    lazy var keychain = KeychainSwift()
    lazy var transitionButton: TouchableBounceView = createTouchableBounceButton(withText: "Next")
    lazy var blurView: UIVisualEffectView = self.createBlurView()
    lazy var modalView: LinksModalView = self.createModalView()
    lazy var tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissModalView))
    var startingFrame: CGRect?
    var resignedResponder: ((UITextField) -> Void)?
    var selectedLanguagesClosure: ((Set<String>) -> Void)?
    var communicatedUserClosure: ((User?) -> Void)?
    
    var user: User?
    weak var coordinator: MainCoordinator?
    
    var disableKeyboardManager = true {
        didSet {
            print("Keyboard Manager")
            
            
            IQKeyboardManager.shared.enable = disableKeyboardManager
            
    
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("User when we start onboarding flow \(user?.email)")
        
        self.addChild(pageViewController)
        
        self.tapGesture.delegate = self
        
        self.view.addSubview(self.pageViewController.view)
        
        pageViewController.didMove(toParent: self)
        
        self.pageViewController.delegate = self
        
        self.view.backgroundColor = .white
        
        
        self.pageViewController.modalViewTapClosure = {[unowned self] (startingFrame, text) in
            print("Page view controller tap closure")
            // MARK: TODO Have to add a blur view and ANIMATE THE BLUR VIEW
            self.keychain.set(text ?? "", forKey: "linkName")
            self.startingFrame = startingFrame
            self.layoutBlurView()
            self.layoutModalView()
            
            // MARK: Have to add modal view as well
        }
        
        pageViewController.logoImageClosure = {[unowned self] (image, color, linkName) in
            self.modalView.containerView.logoImageView.image = image
            self.blurView.backgroundColor = color
            self.modalView.containerView.linkName = linkName
        }
        
        pageViewController.selectedLanguagesClosure = {[unowned self] languages in
            if let user = self.user {
                user.languages = Array(languages)
                self.coordinator?.setCommunicatedUser(withUser: user)
            }
            
            //            self.coordinator?.setCommunicatedUser(withUser: self.user!)
            print(languages)
        }
        
        pageViewController.completedOnboardingFlowClosure = {[unowned self] in
            self.coordinator?.saveUser()
        }
        
        
        // When the closure that represents that the last onboarding screen has been reached we then send a network request to backend
        
    }
    
    override func viewDidLayoutSubviews() {
        
        layout()
    }
    
    
    
    func layoutTransitionButton() {
        self.view.addSubview(transitionButton)
        
        
        self.transitionButton.backgroundColor = .init(hexString: "317AC1")
        self.transitionButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(transitionNextPage)))
        
        self.transitionButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.pageViewController.view.snp.bottom)
            
            make.height.equalTo(65)
            make.width.equalTo(300)
            //            make.bottom.equalToSuperview().offset(-(differenceInHeight))
            
        }
    }
    
    @objc func transitionNextPage() {
        self.pageViewController.nextPage()
    }
    
    @objc func dismissModalView() {
        print("USER WANTS TO DISMISS MODAL VIEW")
        self.blurView.layer.cornerRadius = 20
        self.view.isUserInteractionEnabled = false
        guard let startingFrame = self.startingFrame else {return}
        self.blurView.autoresizesSubviews = true
        
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            //            self.blurView.snp.makeConstraints({ (make) in
            //                self.start
            //            })
            
            self.blurView.frame = startingFrame
            self.modalView.alpha = 0.0
            self.blurView.alpha = 0.0
            
        }) { _ in
            self.blurView.removeFromSuperview()
            self.view.isUserInteractionEnabled = true
            
            self.disableKeyboardManager = true
            
            // MARK: TODO FIX Separation of concerns this file should not know about username text field two subviews down the hierarchy
            self.modalView.containerView.usernameTextField.resignFirstResponder()
            self.modalView.containerView.usernameTextField.text = ""
            
        }
        
        
    }
}

// HOW THE NEW FLOW WILL GO IS THAT THIS SCREEN CONTAINS THE TRANSITION BUTTON AND EACH ONBOARDING PAGE IS HANDLED BY THE PAGE VIEW CONTROLLER WHICH IS CREATED HERE THEREFORE THIS NAME SHOULD BE ONBOARDING CONTROLLER

// ONBOARDING CONTROLLER SHOULD BE RENAMED TO FIRSTONBOARDINGCONTROLLER due it only having knowledge of the first onboarding screen

// FACTORY EXTENSION
extension OnboardingViewController {
    func createBlurView() -> UIVisualEffectView {
        let blurEffect = UIBlurEffect(style: .prominent)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.alpha = 0.0
        return blurView
    }
    
    func createModalView() -> LinksModalView {
        guard let startingFrame = self.startingFrame else {fatalError()}
        let modalView = LinksModalView(frame: startingFrame)
        modalView.layer.cornerRadius = 20
        modalView.alpha = 0.0
        return modalView
    }
    
    func createOnboardingPageViewController() -> OnboardingPageViewController {
        let pageViewController = OnboardingPageViewController()
        return pageViewController
    }
    
}

// Layout Extension

extension OnboardingViewController {
    func layout() {
        
        layoutOnboardingPageViewController()
        
        
        layoutTransitionButton()
        transformTouchableBounceView(withBounceView: self.transitionButton)
    }
    
    func layoutOnboardingPageViewController() {
        
        let height = self.view.bounds.height
        self.pageViewController.view.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(height * 0.85)
            
        }
        
    }
    
    func layoutBlurView() {
        self.view.addSubview(blurView)
        blurView.addGestureRecognizer(self.tapGesture)
        blurView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        UIView.animate(withDuration: 0.5) {
            self.blurView.alpha = 1.0
        }
    }
    
    func layoutModalView() {
        self.blurView.contentView.addSubview(self.modalView)
        modalView.successDelegate = self
        self.disableKeyboardManager = true
        self.modalView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalToSuperview().dividedBy(1.5)
            make.height.equalToSuperview().dividedBy(3)
        }
        
        UIView.animate(withDuration: 0.5) {
            self.modalView.alpha = 1.0
        }
        self.modalView.linkTextClosure = {[unowned self] linkText in
            
            if let user = self.user {
                if let linkName = self.keychain.get("linkName") {
                    switch linkName {
                    case "Medium":
                        self.user?.mediumProfileUsername = linkText
                        self.coordinator?.setCommunicatedUser(withUser: user)
                    case "Twitter":
                        self.user?.twitterProfileUsername = linkText
                        self.coordinator?.setCommunicatedUser(withUser: user)
                    case "Github":
                        self.user?.githubProfileUsername = linkText
                        self.coordinator?.setCommunicatedUser(withUser: user)
                    case "LinkedIn":
                        self.user?.linkedInProfileUsername = linkText
                        self.coordinator?.setCommunicatedUser(withUser: user)
                    case "Personal Website":
                        self.user?.personalWebsite = linkText
                        self.coordinator?.setCommunicatedUser(withUser: user)
                    default:
                        break
                    }
                }
            }
            
            
        }
    }
    
}

extension OnboardingViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard let view = touch.view else {return false}
        //
        if view.isDescendant(of: self.modalView) {
            return false
        }
        
        return true
    }
}


extension OnboardingViewController: DismissModalViewDelegate {
    func successHasPlayed() {
        dismissModalView()
    }
}
