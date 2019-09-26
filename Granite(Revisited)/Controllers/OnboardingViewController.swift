//
//  TestViewController.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 8/5/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit

class OnboardingViewController: UIViewController, UIPageViewControllerDelegate {
    // Used to test the embedding of a page view controller
    
    //    var pageViewController = OnboardingPageViewController()
    lazy var pageViewController: OnboardingPageViewController = self.createOnboardingPageViewController()
    
    lazy var transitionButton: TouchableBounceView = createTouchableBounceButton(withText: "Next")
    lazy var blurView: UIVisualEffectView = self.createBlurView()
    lazy var modalView: LinksModalView = self.createModalView()
    lazy var tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissModalView))
    var startingFrame: CGRect?
    var resignedResponder: ((UITextField) -> Void)?
    
    var communicatedUserClosure: ((User?) -> Void)?
    
    var user: User?
    
    init(user: User?=nil) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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
        
        
        self.pageViewController.modalViewTapClosure = {[weak self] (startingFrame, text) in
            print("Page view controller tap closure")
            // MARK: TODO Have to add a blur view and ANIMATE THE BLUR VIEW
            self?.startingFrame = startingFrame
            self?.layoutBlurView()
            self?.layoutModalView()
            
            // MARK: Have to add modal view as well
        }
        
        pageViewController.logoImageClosure = {[unowned self] (image, color, linkName) in
            self.modalView.containerView.logoImageView.image = image
            self.blurView.backgroundColor = color
            self.modalView.containerView.linkName = linkName
        }
        
        self.communicatedUserClosure = {[unowned self] user in
            print(user)
        }
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
        self.modalView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalToSuperview().dividedBy(1.5)
            make.height.equalToSuperview().dividedBy(3)
        }
        
        UIView.animate(withDuration: 0.5) {
            self.modalView.alpha = 1.0
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
