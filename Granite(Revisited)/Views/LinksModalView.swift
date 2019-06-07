//
//  LinksModalView.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 5/30/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit
import Lottie


class LinksModalView: UIView, KeyboardDelegate, EndEditingDelegate {
    @IBOutlet weak var linkName: UILabel!
    var containerView: LinksModalContainerView!
    @IBOutlet weak var pleaseEnterLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    var exitButton: UIButton!
    var bottomConstraint: NSLayoutConstraint!
    
    var animationContainer: UIView!
    
    weak var successDelegate: DismissModalViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func keyboardIsActive() {
        print("Keyboard has been activated")
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIWindow.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willHideKeyboard), name: UIWindow.keyboardWillHideNotification, object: nil)
    }
    
    //    MARK: TODO Delegate to notify modal view that keyboard has come up
    
    @objc func handleKeyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            guard let keyboardFrame = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? CGRect else {return}
            
            self.frame.origin.y -= keyboardFrame.height / 2
            
        }
        
        NotificationCenter.default.removeObserver(self, name: UIWindow.keyboardWillShowNotification, object: nil)
    }
    
    @objc func willHideKeyboard(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            guard let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {return}
            
            self.frame.origin.y += keyboardFrame.height / 2
            
        }
        
        NotificationCenter.default.removeObserver(self, name: UIWindow.keyboardWillHideNotification, object: nil)
    }
    
    func commonInit() {
        // MARK: TODO Add shadow to container view
        Bundle.main.loadNibNamed("LinksModalView", owner: self, options: nil)
        
        
        
        self.containerView = LinksModalContainerView(frame: .init(x: self.bounds.midX, y: self.bounds.midY, width: self.bounds.width, height: self.bounds.height))
        addSubviews(views: linkName, containerView)
        
        linkName.textAlignment = .center
        
        
        // MARK: TODO Translation in whole view's Y and alpha 0 initially
        
        self.backgroundColor = UIColor(hexString: "4790e6")
        containerView.backgroundColor = .white
        
        linkName.constrainHeight(withHeight: self.frame.height - (self.frame.height - 75))
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: .init(top: 75, left: 0, bottom: 0, right: 0))
        
        self.bottomConstraint = NSLayoutConstraint(item: containerView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        self.addConstraint(bottomConstraint)
        containerView.layer.cornerRadius = 20
        
        containerView.keyboardDelegate = self
        containerView.endEditingDelegate = self
        
        self.linkName.textColor = .white
        
        
        let attributedText = createLabelSpacing(withLabelText: "Improve Your Experience On The Application")
        self.linkName.attributedText = attributedText
        
        self.linkName.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18)
        self.linkName.lineBreakMode = .byWordWrapping
        self.linkName.numberOfLines = 0
        self.linkName.textAlignment = .center
        
        
    }
    
    func returnWasPressed() {
        print("Return Key was pressed!")
        
        self.animationContainer = UIView(frame: self.bounds)
        
        let animationView = LOTAnimationView(name: "success")
        animationContainer.layer.cornerRadius = 20
        
//        animationView.backgroundColor = .init(hexString: "d7b9d5")
        animationView.backgroundColor = .white
        
        animationView.frame = animationContainer.bounds
        animationContainer.addSubview(animationView)
        
        animationView.layer.cornerRadius = 20
        
        self.addSubview(animationContainer)
        
        animationView.alpha = 0.0
        
        animationContainer.alpha = 0.0
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
            self.animationContainer.alpha = 1.0
            self.animationContainer.backgroundColor = .white
        }) { _ in
            UIView.animate(withDuration: Double(animationView.animationDuration) + 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
                animationView.alpha = 1.0
                
                animationView.play()
            }, completion: {_ in
//                animationContainer.removeFromSuperview()
                self.successDelegate?.successHasPlayed()
            })
        }
    }
    
    func removeAnimationContainer() {
        self.animationContainer.removeFromSuperview()
    }
    
    func createExitButton() {
        self.exitButton = UIButton()
        self.exitButton.setTitle("✕", for: .normal)
        self.addSubview(exitButton)
        exitButton.backgroundColor = .clear
        exitButton.contentVerticalAlignment = .top
        exitButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 20)
        
        self.exitButton.frame = .init(x: self.bounds.maxX, y: self.bounds.minY, width: 20, height: 20)
        self.exitButton.anchor(top: self.topAnchor, leading: self.linkName.trailingAnchor, bottom: self.containerView.topAnchor, trailing: self.trailingAnchor)
    }
    
}
