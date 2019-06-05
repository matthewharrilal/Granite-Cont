//
//  LinksModalView.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 5/30/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit

class LinksModalView: UIView, KeyboardDelegate {
    @IBOutlet weak var linkName: UILabel!
    var containerView: LinksModalContainerView!
    @IBOutlet weak var pleaseEnterLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    var exitButton: UIButton!
    var bottomConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func keyboardIsActive() {
        print("Keyboard has been activated")
//        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIWindow.keyboardWillShowNotification, object: nil)
        
    }
    
//    MARK: TODO Delegate to notify modal view that keyboard has come up
    
//    @objc func handleKeyboardNotification(notification: NSNotification) {
//        if let userInfo = notification.userInfo {
//            guard let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {return}
//            self.bottomConstraint.constant -= keyboardFrame.height
//        }
//    }
    
    
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
