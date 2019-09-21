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
    
    lazy var pageViewController = OnboardingPageViewController()
    lazy var transitionButton: TouchableBounceView = createTouchableBounceButton(withText: "Next")
    lazy var blurView: UIVisualEffectView = self.createBlurView()
    lazy var modalView: LinksModalView = self.createModalView()
    lazy var tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissModalView))
    var startingFrame: CGRect?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.addChild(pageViewController)
        
        self.tapGesture.delegate = self
        
        self.view.addSubview(self.pageViewController.view)
        
        pageViewController.didMove(toParent: self)
        
        self.pageViewController.delegate = self
        
//        self.pageViewController.delegate = self
//        self.pageViewController.dataSource = self
        
        self.view.backgroundColor = .white
        
        
        self.pageViewController.modalViewTapClosure = {[weak self] (startingFrame, text) in
            print("Page view controller tap closure")
            // MARK: TODO Have to add a blur view and ANIMATE THE BLUR VIEW
            self?.startingFrame = startingFrame
            self?.layoutBlurView()
            self?.layoutModalView()
            // MARK: Have to add modal view as well
        }
        
        pageViewController.logoImageClosure = {[unowned self] image in
            self.modalView.containerView.logoImageView.image = image
        }
    }
    
    override func viewDidLayoutSubviews() {
        
        let height = self.view.bounds.height
        self.pageViewController.view.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(height * 0.85)
            
        }
        
        layoutTransitionButton()
        transformTouchableBounceView(withBounceView: self.transitionButton)
    }
    
    
    func layoutTransitionButton() {
        self.view.addSubview(transitionButton)
        
        let differenceInHeight = self.view.bounds.height - (self.view.bounds.height * 0.85)
        
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
    }
}

// HOW THE NEW FLOW WILL GO IS THAT THIS SCREEN CONTAINS THE TRANSITION BUTTON AND EACH ONBOARDING PAGE IS HANDLED BY THE PAGE VIEW CONTROLLER WHICH IS CREATED HERE THEREFORE THIS NAME SHOULD BE ONBOARDING CONTROLLER

// ONBOARDING CONTROLLER SHOULD BE RENAMED TO FIRSTONBOARDINGCONTROLLER due it only having knowledge of the first onboarding screen

// FACTORY EXTENSION
extension OnboardingViewController {
    func createBlurView() -> UIVisualEffectView {
        let blurEffect = UIBlurEffect(style: .prominent)
        let blurView = UIVisualEffectView(effect: blurEffect)
        return blurView
    }
    
    func createModalView() -> LinksModalView {
        guard let startingFrame = self.startingFrame else {fatalError()}
        let modalView = LinksModalView(frame: startingFrame)
        modalView.layer.cornerRadius = 20
        return modalView
    }
}

// Layout Extension

extension OnboardingViewController {
    func layout() {
        layoutBlurView()
        layoutModalView()
    }
    
    func layoutBlurView() {
        self.view.addSubview(blurView)
        blurView.addGestureRecognizer(self.tapGesture)
        blurView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func layoutModalView() {
        self.blurView.contentView.addSubview(self.modalView)
        self.modalView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalToSuperview().dividedBy(1.5)
            make.height.equalToSuperview().dividedBy(3)
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
