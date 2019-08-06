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
    var animationView: LOTAnimationView!
    
    var transitionButton: TouchableBounceView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    fileprivate func commonInit() {
        Bundle.main.loadNibNamed("FirstOnboardingScreen", owner: self, options: nil)
        
        self.transitionButton = createTouchableBounceButton(withText: "Next")
        self.addSubviews(views: welcomeLabel, descriptionLabel, self.transitionButton)
        self.backgroundColor = .init(hexString: "fefeff")
        
        
        self.transitionButton.frame = CGRect(x: self.center.x, y: self.frame.height * 0.88, width: 300, height: 65)
        self.transitionButton.center.x = self.center.x
        
        self.transitionButton.backgroundColor = .blue
        
//        self.transitionButton.snp.makeConstraints { (make) in
//            make.centerX.equalToSuperview()
//            make.width.equalTo(300)
//            make.height.equalTo(65)
//        }
        
        welcomeLabel.text = "Welcome to Granite"
        
        
        
        let descriptionText = createLabelSpacing(withLabelText: "Before we connect you with other developers, we have a few questions that will help improve your experience")
        
        descriptionLabel.attributedText = descriptionText
        
        welcomeLabel.font = .bold(size: 20)
        descriptionLabel.font = .regular(size: 18)
        
        // Start off invisible then animate the difference
        welcomeLabel.alpha = 0.0
        descriptionLabel.alpha = 0.0
        transitionButton.alpha = 0.0
        
        
        
        
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        
        descriptionLabel.anchor(top: welcomeLabel.safeAreaLayoutGuide.bottomAnchor, leading: self.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: self.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 20, bottom: 0, right: -20))
        descriptionLabel.sizeToFit()
        
    }
    
    func animateLabels() {
        UIView.animateKeyframes(withDuration: 0.7, delay: 0.0, options: .calculationModeCubic, animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1.0, animations: {
                self.welcomeLabel.alpha = 1.0
               
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 1.0, animations: {
                self.descriptionLabel.alpha = 1.0
                self.transitionButton.alpha = 1.0
            })
        }) { (_) in
            self.configureAnimation()
        }
    }
    
    
    func configureAnimation() {
        
        animationView = LOTAnimationView(name: "success")
        animationView.contentMode = .scaleAspectFit
        
        animationView.play()
        
        
        animationView.animationSpeed = 0.5
        
        addSubview(animationView)
        
        animationView.anchor(top: self.descriptionLabel.bottomAnchor, leading: self.leadingAnchor, bottom: self.transitionButton.topAnchor, trailing: self.trailingAnchor, padding: .init(top: 0, left: 20, bottom: -20, right: -20))
    }
    
    func transformViews(views: UIView...) {
        views.forEach { (view) in
            view.transform = CGAffineTransform(translationX: 0, y: -self.frame.maxY)
        }
    }
    
    //    func createCurvedBezierPath() {
    //        // In charge of creating the curved animation
    //
    //        let bezierPath = UIBezierPath()
    //        let shape = CAShapeLayer()
    //
    //        let sampleView = UIView(frame: self.frame)
    //
    //        sampleView.backgroundColor = .white
    //        addSubview(sampleView)
    //
    //        let middleOfScreenX = self.frame.width / 2
    //        var middleOfScreenY = self.frame.height / 2
    //        let endOfScreenX = self.frame.width
    //        let startPoint = CGPoint(x: frame.minX, y: frame.midY)
    //
    //        var updatedX: CGFloat = 0
    //        var updatedY: CGFloat = 0
    //
    //
    //        bezierPath.move(to: startPoint)
    //
    //
    //        //        bezierPath.addCurve(to: CGPoint(x: bounds.minX + 120 ,y: bounds.midY + 35), controlPoint1: startPoint, controlPoint2: CGPoint(x: bounds.minX - 80, y:bounds.midY - 400))
    //        bezierPath.addCurve(to: CGPoint(x: middleOfScreenX ,y: bounds.midY - 20),
    //                            controlPoint1: startPoint,
    //                            controlPoint2: CGPoint(x: middleOfScreenX / 2, y:bounds.midY + 100))
    //
    //        updatedX = middleOfScreenX
    //        updatedY = middleOfScreenY - 20
    //        bezierPath.move(to: .init(x: updatedX, y: updatedY))
    //
    //        //        let remainingScreenWidth = (self.frame.width - middleOfScreenX) // Gives us two equal remaining portion of the screen
    //
    //        bezierPath.addCurve(to: .init(x: middleOfScreenX + 80, y: middleOfScreenY - 61),
    //                            controlPoint1: .init(x: updatedX, y: updatedY) ,// To match the previous end point
    //            controlPoint2: .init(x: middleOfScreenX + 14, y: middleOfScreenY - 40))
    //
    //        updatedX = middleOfScreenX + 80
    //        updatedY = middleOfScreenY - 61
    //
    //        bezierPath.move(to: .init(x: updatedX, y:updatedY))
    //
    //        bezierPath.addCurve(to: .init(x: endOfScreenX, y: middleOfScreenY - 30), // May have to chaneg the y pos
    //            controlPoint1: .init(x: updatedX, y: updatedY),
    //            controlPoint2: .init(x: updatedX + 38, y: updatedY - 15))
    //
    //        updatedX = endOfScreenX
    //        updatedY = middleOfScreenY - 30
    //
    //        bezierPath.move(to: .init(x: updatedX, y: updatedY))
    //
    //        // First Line
    //        bezierPath.addLine(to: .init(x: self.frame.maxX, y: self.frame.maxY))
    //
    //        updatedX = self.frame.maxX
    //        updatedY = self.frame.maxY
    //
    //        // Second Line
    //        bezierPath.addLine(to: .init(x: self.frame.minX, y: self.frame.maxY))
    //
    //        updatedX = self.frame.minX
    //
    //
    //
    //        bezierPath.move(to: .init(x: updatedX, y: updatedY))
    //
    //        // Third Line
    //        bezierPath.addLine(to: startPoint)
    //
    //        bezierPath.close()
    //
    //
    //        shape.path = bezierPath.cgPath
    //
    //        shape.strokeColor = UIColor.orange.cgColor
    //        shape.lineWidth = 4
    //
    //
    //        shape.fillColor = UIColor.red.cgColor
    //
    //
    //        sampleView.layer.addSublayer(shape)
    //
    //    }
    
}
