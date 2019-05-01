//
//  ViewController.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 4/17/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import UIKit
import Lottie
import Hero

class LaunchScreenViewController: UIViewController {
    
    var enterButton: UIButton!
    
    var shapeLayer: CAShapeLayer!
    
    var pulsatingLayer: CAShapeLayer!
    
    var touchView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // MARK: FIX Display animation then transition to initial view of the screen
        
        // TODO: MARK Why is our subview's layers not appearing
        //        configureTouchView()
        
        configureAnimation()
        configureEnterButton()
    }
    
    private func configureTouchView() {
        let frame = CGRect(x: self.view.center.x, y: 700, width: 400, height: 400)
        self.touchView = UIView(frame: frame)
        touchView.backgroundColor = .red
        self.view.addSubview(touchView)
    }
    
    private func configureAnimation() {
        self.view.backgroundColor = UIColor(hexString: "c9ddff")
        
        let animationView = LOTAnimationView(name: "launchAnimation")
        animationView.contentMode = .scaleAspectFit
        
        
        animationView.loopAnimation = true
        self.view.addSubview(animationView)
        
        animationView.frame = self.view.bounds
        
        animationView.animationSpeed = 2
        
        animationView.play { (completed) in
            print("Has completed animation? -> \(completed)")
        }
    }
    
    private func configureEnterButton() {
        shapeLayer = CAShapeLayer()
        
        let position = CGPoint(x: self.view.center.x, y: 700)
        
        let circularPath = UIBezierPath(arcCenter: position , radius: 50, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeEnd = 0
        shapeLayer.strokeColor = UIColor(hexString: "98c9a3").cgColor
        shapeLayer.lineWidth = 10
        
        shapeLayer.shadowColor = UIColor.black.cgColor
        shapeLayer.shadowOpacity = 1
        shapeLayer.shadowRadius = 10
        shapeLayer.shadowOffset = .zero
        
        
        configurePulsatingLayer()
        
        animatePulsatingLayer()
        
        animateStroke(with: &shapeLayer)
        
        self.view.layer.addSublayer(shapeLayer)
    }
    
    private func animateStroke(with shapeLayer: inout CAShapeLayer) {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        basicAnimation.toValue = 1.5
        basicAnimation.duration = 1
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayer.add(basicAnimation, forKey: "strokeAnimation")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first // Get the first touch of the user
        
        guard let point = touch?.location(in: self.view) else {return}
        
        let convertedPoint = self.view.layer.convert(point, to: self.shapeLayer)
        
        // Have to check if the path of the shape layer contains the point not the shape layer itself
        if let path = self.shapeLayer.path, path.contains(convertedPoint) {
            print("Contains point in path")
            transitionToLogin()
        }
            
        else {
            print("Does not contain point in path")
        }
    }
    
    // TODO: MARK Handle tap
    private func transitionToLogin() {
        let loginViewController = LogInViewController()
        loginViewController.hero.isEnabled = true
        
        loginViewController.hero.modalAnimationType = .fade
        self.present(loginViewController, animated: true, completion: nil)
    }
}



