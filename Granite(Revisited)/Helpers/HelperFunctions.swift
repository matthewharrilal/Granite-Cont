//
//  HelperFunctions.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 5/29/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit

func createLabelSpacing(withLabelText labelText: String) -> NSMutableAttributedString {
    let paragraph = NSMutableParagraphStyle()
    paragraph.lineSpacing = 15
    
    let attributedString = NSMutableAttributedString(string: labelText)
    
    attributedString.addAttribute(.paragraphStyle, value: paragraph, range: NSMakeRange(0, attributedString.length))
    
    return attributedString
}

func createTouchableBounceButton(withText text: String) -> TouchableBounceView {
    let button = TouchableBounceView()
    button.backgroundColor = UIColor.init(hexString: "2357A5")
    button.layer.cornerRadius = 8
    let container = UIView()
    button.addSubview(container)
    
    container.snp.makeConstraints { (make) in
        make.edges.equalToSuperview()
    }
    
    let textLabel = UILabel()
    
    container.addSubview(textLabel)
    
    textLabel.text = text
    textLabel.textColor = .white
    textLabel.font = UIFont.regular(size: 17)
    
    textLabel.snp.makeConstraints { (make) in
        make.center.equalToSuperview()
    }
    
    return button
}

func transformTouchableBounceView(withBounceView bounceView: TouchableBounceView) {
    // Apply scaling transformation to button
    
    print("Animating touchable bounce view button")
    
    bounceView.transform = .init(scaleX: 1.05, y: 1.05)
    
    UIView.animate(withDuration: 1.0, delay: 0.0, options: [.autoreverse, .repeat, .allowUserInteraction], animations: {
        bounceView.transform = .identity
    }) { (_) in
        
    }
}


func createTransitionButton(withView view: UIView) -> UIButton {
    let transitionButton = UIButton()
    
    let frame = CGRect(x: view.center.x, y: view.frame.height * 0.88, width: 65, height: 65)
    
    transitionButton.frame = frame
    
    transitionButton.layer.cornerRadius = transitionButton.frame.height / 2
    transitionButton.setTitle("", for: .normal)
    transitionButton.backgroundColor = UIColor(hexString: "585b6d")
    //        transitionButton.backgroundColor = UIColor(hexString: "919098")
    
    
    transitionButton.center.x = view.center.x
    
    let templateImage = #imageLiteral(resourceName: "down").withRenderingMode(.alwaysTemplate)
    
    
    let imageView = UIImageView(image: templateImage)
    imageView.tintColor = .white
    
    transitionButton.addSubview(imageView)
    imageView.constrainHeight(withHeight: 40)
    imageView.constrainWidth(withWidth: 40)
    
    imageView.centerInSuperview()
    
    view.addSubview(transitionButton)
    
    return transitionButton
    
}

func removeChildViews(views: UIView...) {
    views.forEach { (view) in
        view.removeFromSuperview()
    }
}

func applyTransformation(withButton button: UIButton) {
    print("ANIMATING TRANSITION BUTTON")
    button.transform = CGAffineTransform(translationX: 0, y: -20).scaledBy(x: 0.7, y: 0.7)
    //    button.frame.size =
    button.layer.shadowColor = UIColor.black.cgColor
    //    button.layer.shaw
    UIView.animate(withDuration: 1.0, delay: 0.0, options: [.autoreverse, .repeat, .allowUserInteraction], animations: {
        button.transform = .identity
    }) { (_) in
        
    }
}

func applyHorizontalTransformation(withButton button: UIButton) {
    button.transform = CGAffineTransform(translationX: 20, y: 0).scaledBy(x: 0.7, y: 0.7)
    button.layer.shadowColor = UIColor.black.cgColor
    
    UIView.animate(withDuration: 1.0, delay: 0.0, options: [.autoreverse, .repeat, .allowUserInteraction], animations: {
        button.transform = .identity
    }) { (_) in
        
    }
}


func animateViewBorder(withHexColor hexColor: String?=nil, color: UIColor?=nil, withBorder border: inout CALayer) {
    
    let animationColor = CABasicAnimation(keyPath: "backgroundColor")
    
    
    if let hexColor = hexColor {
        animationColor.fromValue = UIColor.lightGray.cgColor
        animationColor.toValue = UIColor.init(hexString: hexColor).cgColor
        animationColor.duration = 0.25
        border.backgroundColor = UIColor.init(hexString: hexColor).cgColor
    }
    border.add(animationColor, forKey: "backgroundColor")
    
}

func createViewBorder(withSuperLayer view: UIView, withBorder border: inout CALayer) {
    border.frame = .init(x: 0, y: view.bounds.maxY - 2, width: view.bounds.width, height: 2)
    view.layer.addSublayer(border)
    border.backgroundColor = UIColor.red.cgColor
}

func resetViewBorder(withBorder border: inout CALayer) {
    border.backgroundColor = UIColor.lightGray.cgColor
}


func createTextFieldStackView() -> UIStackView {
    let stackView = UIStackView()
    stackView.distribution = .fillEqually
    stackView.axis = .vertical
    stackView.alignment = .center
    stackView.spacing = 5
    
    return stackView
}

func createPlaceholderLabel(withText text: String) -> UILabel {
    let label = UILabel()
    label.text = text
    label.alpha = 0.0
    label.font = .regular(size: 13)
    return label
}

func createCustomTextField(withView view: UIView, placeholder: String, selector: Selector? = nil) -> UITextField{
    let textField = UITextField()
    textField.placeholder = placeholder
    textField.font = .regular()
    textField.borderStyle = .none
    textField.layer.borderColor = UIColor.init(hexString: "8CDFD6").cgColor
    
    if let selector = selector {
        textField.addGestureRecognizer(UITapGestureRecognizer(target: view, action: selector))
    }
    
    return textField
}
