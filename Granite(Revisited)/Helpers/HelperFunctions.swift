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


func createTransitionButton(withView view: UIView) -> UIButton {
    let transitionButton = UIButton()
    
    let frame = CGRect(x: view.center.x, y: view.frame.height * 0.88, width: 80, height: 80)
    
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


func applyTransformation(withButton button: UIButton) {
    UIView.animate(withDuration: 1.0, delay: 0.0, options: [.autoreverse, .repeat, .allowUserInteraction], animations: {
        button.transform = CGAffineTransform(translationX: 0, y: -30)
    }) { (_) in
    }
}
