//
//  SignUpView.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 6/6/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit
import Lottie

class SignUpView: UIView {
    @IBOutlet weak var animationContainerView: UIView!
    @IBOutlet weak var createAccountView: UIView!
    @IBOutlet weak var transitionView: UIView!
    var textFieldView: UIView!
    var innerContainerView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        
        animateInnerContainerView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("SignUpView", owner: self, options: nil)
        addSubviews(views: animationContainerView, createAccountView)
        self.animationContainerView.frame = .init(x: self.bounds.minX, y: self.bounds.minY, width: self.bounds.width, height: self.bounds.height / 3)
        
        self.createAccountView.frame = .init(x: self.bounds.midX, y: createAccountView.frame.origin.y, width: self.bounds.width / 1.3, height: self.bounds.height / 2)
        
        self.createAccountView.center = self.center
        
        self.backgroundColor = .init(hexString: "d5b9b2")
        
        self.createAccountView.anchor(top: self.animationContainerView.bottomAnchor, leading: self.safeAreaLayoutGuide.leadingAnchor, bottom: self.safeAreaLayoutGuide.bottomAnchor, trailing: self.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 10, left: -50, bottom: 50, right: -20))
        
        loadAnimationView()
        
        //        self.animationContainerView.backgroundColor = .red
        
        self.createAccountView.backgroundColor = .blue
        
        //        self.transitionView.backgroundColor = .orange
        
        createInnerContainerView()
    }
    
    func loadAnimationView() {
        let animationView = LOTAnimationView(name: "lego")
        animationView.frame = self.animationContainerView.bounds
        
        self.animationContainerView.addSubview(animationView)
        self.animationContainerView.backgroundColor = .init(hexString: "d5b9b2")
        animationView.autoReverseAnimation = true
        animationView.loopAnimation = true
        animationView.play()
    }
    
    func createInnerContainerView() {
        self.createAccountView.layer.cornerRadius = 20
        self.createAccountView.backgroundColor = .init(hexString: "7f7eff")
        
        self.innerContainerView = UIView(frame: .init(x: self.createAccountView.bounds.origin.x, y: self.createAccountView.bounds.origin.y, width: -self.bounds.width, height: self.createAccountView.bounds.height))
        innerContainerView.backgroundColor = .white
        
        self.createAccountView.addSubview(innerContainerView)
        
        self.createAccountView.anchor(top: self.animationContainerView.bottomAnchor, leading: self.leadingAnchor, bottom: innerContainerView.topAnchor, trailing: self.trailingAnchor, padding: .init(top: 10, left: -50, bottom: 10, right: 0 ))
        
        
        
        innerContainerView.layer.cornerRadius = 20
        
        
        
        //        innerContainerView.bounds.width -= self.bounds.width
    }
    
    func animateInnerContainerView() {
        UIView.animate(withDuration: 1.0) {
            self.innerContainerView.frame = .init(x: self.createAccountView.bounds.origin.x, y: self.createAccountView.bounds.origin.y, width: self.bounds.width, height: self.createAccountView.bounds.height)
        }
        
        innerContainerView.anchor(top: self.createAccountView.topAnchor, leading: self.createAccountView.leadingAnchor, bottom: self.createAccountView.bottomAnchor, trailing: self.createAccountView.trailingAnchor, padding: .init(top: 30, left: -50, bottom: 0, right: -20))
    }
    
    //    func createCustomTextField() {
    //        self.textFieldView = UIView(frame: .init(x: self.center.x, y: 60, width: self.frame.width / 2, height: 60))
    //
    //        //
    //
    //        let placeholderLabel = UILabel()
    //
    //        placeholderLabel.text = ""
    //
    //        //
    //        let usernameTextField = UITextField()
    //        usernameTextField.borderStyle = .none
    //        usernameTextField.layer.borderColor = UIColor.init(hexString: "8CDFD6").cgColor
    //        usernameTextField.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
    //        usernameTextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTextFieldTap)))
    //
    //        usernameTextField.backgroundColor = .clear
    //
    //
    //
    //        self.stackView = UIStackView(arrangedSubviews: [self.placeholderLabel, self.usernameTextField])
    //        stackView.distribution = .fillEqually
    //        stackView.axis = .vertical
    //        stackView.alignment = .center
    //        stackView.spacing = 5
    //
    //        textFieldView.addSubview(stackView)
    //        stackView.backgroundColor = .blue
    //
    //        textFieldView.backgroundColor = .clear
    //
    //        self.usernameTextField.constrainHeight(withHeight: stackView.frame.height / 2)
    //
    //        addSubview(textFieldView)
    //        stackView.frame = textFieldView.bounds
    //        stackView.anchorSize(toView: textFieldView)
    //        self.placeholderLabel.anchor(top: stackView.topAnchor, leading: stackView.leadingAnchor, bottom: usernameTextField.topAnchor, trailing: stackView.trailingAnchor)
    //        self.usernameTextField.constrainWidth(withWidth: stackView.bounds.width)
    //
    //        createViewBorder(withSuperLayer: self.textFieldView, withBorder: &self.bottomBorder)
    //    }
    //
    
    
}
