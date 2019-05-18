//
//  FirstOnboardingScreen.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 5/14/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit
import Lottie

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
        transitionButton.alpha = 0.0
        
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
            self.transitionButton.alpha = 1.0
        }
    }
    
    func createLabelSpacing(withLabelText labelText: String) -> NSMutableAttributedString {
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineSpacing = 15
        
        let attributedString = NSMutableAttributedString(string: labelText)
        
        attributedString.addAttribute(.paragraphStyle, value: paragraph, range: NSMakeRange(0, attributedString.length))
        
        return attributedString
    }
    
    func createTransitionButton() {
        let frame = CGRect(x: self.center.x, y: self.frame.height * 0.88, width: 80, height: 80)
        
        transitionButton.frame = frame
        
        transitionButton.layer.cornerRadius = transitionButton.frame.height / 2
        transitionButton.setTitle("", for: .normal)
        transitionButton.backgroundColor = UIColor(hexString: "585b6d")
        //        transitionButton.backgroundColor = UIColor(hexString: "919098")
        
        
        transitionButton.center.x = self.center.x
        
        let image = UIImage(named: "down")
        
        let imageView = UIImageView(image: image)
        
        transitionButton.addSubview(imageView)
        imageView.constrainHeight(withHeight: 40)
        imageView.constrainWidth(withWidth: 40)
        
        imageView.centerInSuperview()
        
        addSubview(transitionButton)
        
        transitionButton.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        
    }
    
    func applyTransformation(withButton button: UIButton) {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: [.autoreverse, .repeat, .allowUserInteraction], animations: {
            button.transform = CGAffineTransform(translationX: 0, y: -30)
        }) { (_) in
        }
    }
    
    @objc func handleTap() {
        print("Transition Button Being Tapped")
        
        let view = UIView(frame: self.bounds)
        
        self.alpha = 0.0
        view.backgroundColor = .red
        
        UIView.animate(withDuration: 2.0, delay: 0.0, options: .curveLinear, animations: {
            self.addSubview(view)
            
            self.center.y -= self.bounds.height
            self.alpha = 1.0
            
        }, completion: nil)
    }
    
    func configureAnimation() {
        
        let animationView = LOTAnimationView(name: "success")
        animationView.contentMode = .scaleAspectFit
        
        animationView.play()
        
        animationView.animationSpeed = 0.5
        
        addSubview(animationView)
        
        animationView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.transitionButton.topAnchor, trailing: self.trailingAnchor, padding: .init(top: 0, left: 20, bottom: -20, right: -20))
    }
    
    func createCurvedBezierPath() {
        // In charge of creating the curved animation
        
        let bezierPath = UIBezierPath()
        let shape = CAShapeLayer()
        
        let sampleView = UIView(frame: self.frame)
        
        sampleView.backgroundColor = .white
        addSubview(sampleView)
        
        let middleOfScreenX = self.frame.width / 2
        var middleOfScreenY = self.frame.height / 2
        
        bezierPath.move(to: .init(x: self.frame.minX, y: self.frame.midY))
//        bezierPath.addLine(to: .init(x: self.frame.width, y: self.frame.height / 2))
        
        bezierPath.addCurve(to: .init(x: middleOfScreenX, y: middleOfScreenY), controlPoint1: .init(x: self.frame.minX, y: middleOfScreenY + 20), controlPoint2: .init(x: middleOfScreenX, y: middleOfScreenY + 20))
        
        bezierPath.addLine(to: .init(x: self.frame.width, y: middleOfScreenY))
        
        shape.path = bezierPath.cgPath
        
        shape.lineWidth = 1
        shape.strokeColor = UIColor.orange.cgColor
        
        sampleView.layer.addSublayer(shape)
    }
    
}
