//
//  LoginView.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 4/17/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit
import Lottie

class LoginView: UIView {
    
    // MARK: TODO Add Back Button
    
    @IBOutlet weak var whiteLoginView: UIView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    
    @IBOutlet weak var lockView: UIView!
    
    var loginStackView: UIStackView!
    
    var shapeLayer: CAShapeLayer!
    
    var configuredView: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        
        //        addConfiguredView()
        
        //        configureAnimation()
    }
    
    private func commonInit() {
        print("Loading login view")
        Bundle.main.loadNibNamed("LoginView", owner: self, options: nil)
        addSubviews(views: whiteLoginView)
        
        usernameTextField.borderStyle = .none
        passwordTextField.borderStyle = .none
        
        usernameTextField.textAlignment = .left
        passwordTextField.textAlignment = .left
        
        
        // MARK: FIX Have to fix the elements in the stack view sizing
        
        
        let loginButtonView = UIView(frame: self.loginButton.frame)
        loginButtonView.addSubview(loginButton)

        loginStackView = UIStackView(arrangedSubviews: [usernameTextField, passwordTextField, loginButton, createAccountButton])
        
        loginStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let padding = UIEdgeInsets(top: 10, left: 10, bottom: -10 , right: -10)
        loginStackView.axis = .vertical
        
        loginStackView.spacing = 10
        
        loginStackView.distribution = .fillProportionally
        
        whiteLoginView.addSubview(loginStackView)
        
        
        loginStackView.fillSuperview(withSuperview: whiteLoginView, padding: padding)
        
        whiteLoginView.layer.cornerRadius = 20
    }
    
    
    func configureLockAnimation() {
        
        let animationView = LOTAnimationView(name: "lock")
        animationView.contentMode = .scaleToFill
        
        animationView.layer.shadowColor = UIColor.black.cgColor
        animationView.layer.shadowOpacity = 1
        animationView.layer.shadowRadius = 10
        animationView.layer.shadowOffset = .zero
        
        self.lockView.addSubview(animationView)
        
        
        animationView.frame = self.lockView.bounds
        
        animationView.play { (completed) in
            print("Has completed animation -> \(completed)")
        }
        
        animationView.loopAnimation = true
        animationView.animationSpeed = 2
    }
}

extension UIView {
    func addSubviews(views: UIView...) {
        views.forEach({addSubview($0)})
    }
}

extension UITextField {
    
    func useUnderline() {
        
        let border = CALayer()
        let borderWidth = CGFloat(1.0)
        border.borderColor = UIColor.black.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - borderWidth, width: self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = borderWidth
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}
