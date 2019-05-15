//
//  FirstOnboardingScreen.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 5/14/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit

class FirstOnboardingScreen: UIView {
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    lazy var pulsatingLayer = CAShapeLayer()
    lazy var shapeLayer = CAShapeLayer()
    
    lazy var transitionButton = UIButton()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    fileprivate func commonInit() {
        Bundle.main.loadNibNamed("FirstOnboardingScreen", owner: self, options: nil)
        self.addSubviews(views: welcomeLabel, descriptionLabel)
        self.backgroundColor = .white
        
        welcomeLabel.text = "Welcome to Granite"
        
        let descriptionText = createLabelSpacing(withLabelText: "Before we connect you with other developers, we have a few questions that will help improve your experience")
        
        descriptionLabel.attributedText = descriptionText
        
        welcomeLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 20)
        descriptionLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18)
        
        // Start off invisible then animate the difference
        welcomeLabel.alpha = 0.0
        descriptionLabel.alpha = 0.0
        
        //        createTransitionButton()
        
        
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        
        descriptionLabel.anchor(top: welcomeLabel.safeAreaLayoutGuide.bottomAnchor, leading: self.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: self.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 20, bottom: 0, right: -20))
        descriptionLabel.sizeToFit()
        
    }
    
    func animateLabels() {
        UIView.animate(withDuration: 2.0) {
            let animation = CAAnimation()
            self.welcomeLabel.alpha = 1.0
            self.descriptionLabel.alpha = 1.0
        }
    }
    
    func createLabelSpacing(withLabelText labelText: String) -> NSMutableAttributedString {
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineSpacing = 10
        
        let attributedString = NSMutableAttributedString(string: labelText)
        
        attributedString.addAttribute(.paragraphStyle, value: paragraph, range: NSMakeRange(0, attributedString.length))
        
        return attributedString
    }
    
    func createTransitionButton() {
        let frame = CGRect(x: self.center.x, y: self.frame.height * 0.88, width: 60, height: 60)
        
        transitionButton.frame = frame
        
        transitionButton.layer.cornerRadius = transitionButton.frame.height / 2
        transitionButton.setTitle("H", for: .normal)
        transitionButton.backgroundColor = .red
        
        transitionButton.center.x = self.center.x
        
        addSubview(transitionButton)
        
//        self.pulsatingLayer.addSublayer(self.transitionButton.layer)
    }
    
    func startAnimation() {
        
        
//        configureEnterButton(withPulsatingLayer: &self.pulsatingLayer, withShapeLayer: &self.shapeLayer, onView: self)
        
    }
}
