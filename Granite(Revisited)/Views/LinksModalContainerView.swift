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
    //    @IBOutlet weak var usernameTextField: UITextField!
    lazy var textFieldView: UIView = self.createTextView()
    //    var stackView: UIStackView!
    lazy var bottomBorder = CALayer()
    var confirmationButton: UIButton!
    var imageName: String?
    var logoImageClosure: ((UIImage) -> Void)?
    lazy var stackView: UIStackView = createTextFieldStackView()
    
    weak var keyboardDelegate: KeyboardDelegate?
    weak var endEditingDelegate: EndEditingDelegate?
    
    //    @IBOutlet weak var placeholderLabel: UILabel!
    lazy var placeholderLabel: UILabel = self.createPlaceholderLabel()
    lazy var usernameTextField: UITextField = self.createUsernameTextField()
    
    var linkName = "" {
        didSet {
            
            if linkName == "Personal Website" {usernameTextField.placeholder = "Website Link"
                placeholderLabel.text = "Website Link"
            }
                
            else{usernameTextField.placeholder = "\(linkName) Username"
                placeholderLabel.text = "\(linkName) Username"
            }
            self.placeholderLabel.alpha = 0.0
            resetViewBorder(withBorder: &self.bottomBorder)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }
    
    override func layoutSubviews() {
        //        commonInit()
        layout()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    fileprivate func commonInit() {
        Bundle.main.loadNibNamed("LinksModalContainerView", owner: self, options: nil)
        addSubviews(views: logoImageView)
        
        //        createConfirmationButton()
        
        self.usernameTextField.delegate = self
        self.usernameTextField.returnKeyType = .go
        
        
        self.logoImageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(80)
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
        }
        
        
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
    
    func createTextView() -> UIView {
        //        self.textFieldView = UIView(frame: .init(x: self.center.x, y: self.center.y, width: self.frame.width / 2, height: 60))
        self.textFieldView = UIView()
        //        self.textFieldView.frame.origin = self.center
        //        textFieldView.frame.size = .init(width: self.frame.width / 2, height: 60)
        
        
        
        return textFieldView
        
        //
        
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
        // Use delegate to notify modal view that user is done editing
        
        // What if the user wants to come back
        self.endEditingDelegate?.returnWasPressed()
        textField.endEditing(true)
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    
}

// Factory Extension
extension LinksModalContainerView {
    
    func createPlaceholderLabel() -> UILabel {
        let placeholderLabel = UILabel()
        return placeholderLabel
    }
    
    func createUsernameTextField() -> UITextField {
        let textField = UITextField()
        return textField
    }
}

// Layout Extension
extension LinksModalContainerView {
    func layout() {
        layoutTextView()
    }
    
    func layoutTextView() {
        self.addSubview(self.textFieldView)
        
        layoutStackView()
        
        self.textFieldView.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.width.equalToSuperview().dividedBy(2)
            make.height.equalTo(60)
            make.top.equalTo(self.logoImageView.snp.bottom).offset(10)
        }
        
        DispatchQueue.main.async {
            createViewBorder(withSuperLayer: self.textFieldView, withBorder: &self.bottomBorder)
        }
        
    }
    func layoutStackView() {
        self.textFieldView.addSubview(stackView)
        
        
        
        self.stackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        self.layoutPlaceholderLabel()
        self.layoutTextField()
        
        
    }
    
    func layoutPlaceholderLabel() {
        self.stackView.addArrangedSubview(self.placeholderLabel)
        self.placeholderLabel.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            
        }
    }
    func layoutTextField() {
        self.stackView.addArrangedSubview(usernameTextField)
        usernameTextField.borderStyle = .none
        usernameTextField.layer.borderColor = UIColor.init(hexString: "8CDFD6").cgColor
        usernameTextField.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
        usernameTextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTextFieldTap)))
        
        //
        self.usernameTextField.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            //            make.top.equalTo(placeholderLabel.snp.bottom)
        }
    }
}
