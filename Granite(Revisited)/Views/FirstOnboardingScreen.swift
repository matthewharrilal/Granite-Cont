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
        let sampleView = UIView(frame: self.bounds)
        
        sampleView.backgroundColor = .white
        
        let shape = CAShapeLayer()
        let path = UIBezierPath()
        
        // All paths start from the origin ... move initial point down the screen by 20 units
        path.move(to: .init(x: self.bounds.origin.x, y: 20))
        
        path.addLine(to: .init(x: self.bounds.origin.x + 5, y: 20))
        
//        path.move(to: CGPoint(x: 2, y: 26))
        
        // The first thing that we have to do is add the curve after the initial point
        path.addCurve(to: .init(x: self.bounds.origin.x + 30, y: 20), // ending point
                      controlPoint1: .init(x: self.bounds.origin.x + 15, y: 32), controlPoint2: .init(x: self.bounds.origin.x + 15, y: 28))
        
        path.close()
        
        path.apply(.init(scaleX: 5, y: 5))
        
        shape.path = path.cgPath
        
        sampleView.layer.addSublayer(shape)
        
        shape.fillColor = UIColor.red.cgColor
        
        shape.lineWidth = 5
        
        shape.position = CGPoint(x: self.center.x, y: self.center.y)
        
        shape.frame.size = CGSize(width: self.frame.width / 2, height: self.frame.height / 2)
        
        addSubview(sampleView)
    }
    
    func createBezierPath() {
        let sampleView = UIView(frame: self.bounds)
        sampleView.backgroundColor = .white
        
        let shape = CAShapeLayer()
        // create a new path
        let path = UIBezierPath()
        
        // starting point for the path (bottom left)
        path.move(to: CGPoint(x: 2, y: 26))
        
        // *********************
        // ***** Left side *****
        // *********************
        
        // segment 1: line
        path.addLine(to: CGPoint(x: 2, y: 15))
        
        
        // segment 2: curve
        path.addCurve(to: CGPoint(x: 0, y: 12), // ending point
            // The control points are how deep inward or downard you make between the x's or the y's for example if the difference in x's between control points the curve will go more inward 
            controlPoint1: CGPoint(x: 2, y: 14),
            controlPoint2: CGPoint(x: 0, y: 14))
        
//        // segment 3: line
//        path.addLine(to: CGPoint(x: 0, y: 2))
//
//        // *********************
//        // ****** Top side *****
//        // *********************
//
//        // segment 4: arc START ANGLE TRAVELS TO THE X CENTER AND THE END ANGLE TRAVELS TO THE Y CENTER
//        path.addArc(withCenter: CGPoint(x: 2, y: 2), // center point of circle
//            radius: 2, // this will make it meet our path line
//            startAngle: CGFloat(M_PI), // π radians = 180 degrees = straight left
//            endAngle: CGFloat(3*M_PI_2), // 3π/2 radians = 270 degrees = straight up
//            clockwise: true) // startAngle to endAngle goes in a clockwise direction
//
//        // segment 5: line
//        path.addLine(to: CGPoint(x: 8, y: 0))
//
//        // segment 6: arc
//        path.addArc(withCenter: CGPoint(x: 8, y: 2),
//                    radius: 2,
//                    startAngle: CGFloat(3*M_PI_2), // straight up
//            endAngle: CGFloat(0), // 0 radians = straight right
//            clockwise: true)
//
//        // *********************
//        // ***** Right side ****
//        // *********************
//
//        // segment 7: line
//        path.addLine(to: CGPoint(x: 10, y: 12))
//
//        // segment 8: curve
//        path.addCurve(to: CGPoint(x: 8, y: 15), // ending point
//            controlPoint1: CGPoint(x: 10, y: 14),
//            controlPoint2: CGPoint(x: 8, y: 14))
//
//        // segment 9: line
//        path.addLine(to: CGPoint(x: 8, y: 26))
//
//        // *********************
//        // **** Bottom side ****
//        // *********************
        
        // segment 10: line
        path.close() // draws the final line to close the path
        
        path.apply(.init(scaleX: 10, y: 10))
        
        shape.path = path.cgPath
        
        sampleView.layer.addSublayer(shape)
        
        shape.fillColor = UIColor.red.cgColor
        
        shape.lineWidth = 40
        
        shape.position = CGPoint(x: self.center.x, y: self.center.y)
        
        shape.frame.size = CGSize(width: self.frame.width / 2, height: self.frame.height / 2)
        
        addSubview(sampleView)
    }
}
