//
//  LinksModalContainerView.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 6/1/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit

class LinksModalContainerView: UIView {
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    var textFieldView: UIView!
    var stackView: UIStackView!
    @IBOutlet weak var placeholderLabel: UILabel!
    
    var linkName = "" {
        didSet {
            usernameTextField.placeholder = "\(linkName) Username"
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
    }
    
    @objc func handleTextFieldTap() {
        self.placeholderLabel.alpha = 0.0
        self.placeholderLabel.text = linkName
        UIView.animate(withDuration: 1.0) {
            self.usernameTextField.placeholder = ""
            self.placeholderLabel.alpha = 1.0
        }
        
        createHighlightViewBorder()
    }
    
    func createCustomTextField() {
        self.textFieldView = UIView(frame: .init(x: self.center.x, y: 60, width: self.frame.width / 2, height: 60))
        
        //
        
        placeholderLabel.text = ""
        
        //        textFieldView.addSubview(placeholderLabel)
        //
        //        usernameTextField.frame = .init(x: textFieldView.bounds.minX, y: textFieldView.bounds.midY, width: textFieldView.bounds.width, height: 60)
        //        usernameTextField.borderStyle = .none
        //        usernameTextField.layer.borderColor = UIColor.init(hexString: "8CDFD6").cgColor
        //        usernameTextField.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
        //        usernameTextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTextFieldTap)))
        //
        //        usernameTextField.backgroundColor = .clear
        
        
        //        textFieldView.addSubview(usernameTextField)
        
        self.stackView = UIStackView(arrangedSubviews: [self.placeholderLabel, self.usernameTextField])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.alignment = .center
        
        textFieldView.addSubview(stackView)
        stackView.backgroundColor = .blue
        
        textFieldView.backgroundColor = .clear
        
        self.usernameTextField.constrainHeight(withHeight: stackView.frame.height / 2)
        
        addSubview(textFieldView)
        stackView.frame = textFieldView.bounds
        stackView.anchorSize(toView: textFieldView)
        self.placeholderLabel.anchor(top: stackView.topAnchor, leading: stackView.leadingAnchor, bottom: usernameTextField.topAnchor, trailing: stackView.trailingAnchor)
    }
    
    func createHighlightViewBorder() {
        let bottomBorder = CALayer()
        bottomBorder.backgroundColor = UIColor.init(hexString: "8CDFD6").cgColor
        
        bottomBorder.frame = .init(x: 0, y: textFieldView.bounds.maxY - 2, width: textFieldView.bounds.width, height: 2)
        textFieldView.layer.addSublayer(bottomBorder)
    }
    
    // PRO TIP: The reason we dont constrain size is because we need to know the exact x and y when since the frame changes we don't know for sure
    override func layoutIfNeeded() {
        
        //            self.logoImageView.frame = self.bounds
        //            self.logoImageView.center.x = self.bounds.midX
        //            self.logoImageView.constrainHeight(withHeight: 50)
        //            self.logoImageView.constrainWidth(withWidth: 100)
        
        
    }
}
