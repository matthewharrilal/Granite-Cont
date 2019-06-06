//
//  LinksModalContainerView.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 6/1/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit

class LinksModalContainerView: UIView, UITextFieldDelegate {
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    var textFieldView: UIView!
    var stackView: UIStackView!
    lazy var bottomBorder = CALayer()
    var confirmationButton: UIButton!
    
    weak var keyboardDelegate: KeyboardDelegate?
    
    @IBOutlet weak var placeholderLabel: UILabel!
    
    var linkName = "" {
        didSet {
            usernameTextField.placeholder = "\(linkName) Username"
            placeholderLabel.text = "\(linkName) Username"
            self.placeholderLabel.alpha = 0.0
            resetViewBorder(withBorder: &self.bottomBorder)
        }
    }
    
    var logoImage = UIImage() {
        didSet {
            logoImageView.image = logoImage
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    fileprivate func commonInit() {
        Bundle.main.loadNibNamed("LinksModalContainerView", owner: self, options: nil)
        addSubviews(views: logoImageView)
        
        self.logoImageView.frame = .init(x: 0, y: 20, width: self.frame.width / 3, height: 75)
        createCustomTextField()
//        createConfirmationButton()
        
        self.usernameTextField.delegate = self
        self.usernameTextField.returnKeyType = .go
        
    }
    
    
    @objc func handleTextFieldTap() {
        if let keyboardDelegate = self.keyboardDelegate {
            keyboardDelegate.keyboardIsActive()
        }
        
        self.placeholderLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
        UIView.animate(withDuration: 1.0) {
            self.usernameTextField.placeholder = ""
            self.placeholderLabel.alpha = 0.8
            animateViewBorder(withHexColor: "8CDFD6", withBorder: &self.bottomBorder)
        }
    }
    
    func createCustomTextField() {
        self.textFieldView = UIView(frame: .init(x: self.center.x, y: 60, width: self.frame.width / 2, height: 60))
        
        //
        
        placeholderLabel.text = ""
        
        //
        usernameTextField.borderStyle = .none
        usernameTextField.layer.borderColor = UIColor.init(hexString: "8CDFD6").cgColor
        usernameTextField.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
        usernameTextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTextFieldTap)))
        
        usernameTextField.backgroundColor = .clear
        
        
        
        self.stackView = UIStackView(arrangedSubviews: [self.placeholderLabel, self.usernameTextField])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 5
        
        textFieldView.addSubview(stackView)
        stackView.backgroundColor = .blue
        
        textFieldView.backgroundColor = .clear
        
        self.usernameTextField.constrainHeight(withHeight: stackView.frame.height / 2)
        
        addSubview(textFieldView)
        stackView.frame = textFieldView.bounds
        stackView.anchorSize(toView: textFieldView)
        self.placeholderLabel.anchor(top: stackView.topAnchor, leading: stackView.leadingAnchor, bottom: usernameTextField.topAnchor, trailing: stackView.trailingAnchor)
        self.usernameTextField.constrainWidth(withWidth: stackView.bounds.width)
        
        createViewBorder(withSuperLayer: self.textFieldView, withBorder: &self.bottomBorder)
    }
    
    func createConfirmationButton() {
        self.confirmationButton = UIButton(frame: .init(x: self.bounds.maxX, y: self.bounds.maxY, width: 20, height: 20))
       
        self.confirmationButton.backgroundColor = .white
        
        addSubview(self.confirmationButton)
        
        self.confirmationButton.anchor(top: self.textFieldView.bottomAnchor, leading: self.textFieldView.trailingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor)
        
        self.confirmationButton.setTitle("✔", for: .normal)
        self.confirmationButton.titleLabel?.textColor = .green
      
    }
    
    // PRO TIP: The reason we dont constrain size is because we need to know the exact x and y when since the frame changes we don't know for sure
    override func layoutIfNeeded() {
        
        //            self-----------.logoImageView.frame = self.bounds
        //            self.logoImageView.center.x = self.bounds.midX
        //            self.logoImageView.constrainHeight(withHeight: 50)
        //            self.logoImageView.constrainWidth(withWidth: 100)
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return false
    }
    
}
