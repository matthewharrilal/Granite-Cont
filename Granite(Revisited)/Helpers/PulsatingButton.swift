//
//  PulsatingButton.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 5/3/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit

@discardableResult
func configureEnterButton(withPulsatingLayer pulsatingLayer: inout CAShapeLayer, withShapeLayer shapeLayer: inout CAShapeLayer, onView view: UIView) -> (CAShapeLayer, CAShapeLayer) {
    let position = CGPoint(x: view.center.x, y: view.frame.height * 0.88)
    
    shapeLayer.fillColor = UIColor(hexString: "0b3142").cgColor
    shapeLayer.position = position
    
    let circularPath = UIBezierPath(arcCenter: position , radius: 40, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
    
    shapeLayer.path = circularPath.cgPath
    shapeLayer.strokeEnd = 0
    shapeLayer.strokeColor = UIColor(hexString: "0b3142").cgColor
    shapeLayer.lineWidth = 10
    //
    //    shapeLayer.shadowColor = UIColor.black.cgColor
    //    shapeLayer.shadowOpacity = 1
    //    shapeLayer.shadowRadius = 10
    //    shapeLayer.shadowOffset = .zero
    
    configurePulsatingLayer(onView: view, withPulsatingLayer: pulsatingLayer)
    
    animatePulsatingLayer(withPulsatingLayer: pulsatingLayer)
    
    //    animateStroke(with: &shapeLayer)
    
    shapeLayer.bounds = CGRect(x: view.center.x, y: view.frame.height * 0.88, width: 20, height: 20)
//    shapeLayer.bounds = view.frame
    
//    shapeLayer.bounds = view.frame
    
    let image = UIImage(named: "downArrow")
//    let imageView = UIImageView(image: image)
//
//    let sampleView = UIView(frame: shapeLayer.frame)
//    sampleView.addSubview(imageView)
//
//    sampleView.bounds = shapeLayer.frame
    
    
    shapeLayer.contents = image?.cgImage
    shapeLayer.contentsGravity = .center
//    shapeLayer.masksToBounds = true
    
    view.layer.addSublayer(shapeLayer)
    
    
    return (shapeLayer, pulsatingLayer)
}

func configurePulsatingLayer(onView view: UIView, withPulsatingLayer pulsatingLayer:  CAShapeLayer) {
    
    let circularPath = UIBezierPath(arcCenter: .zero , radius: 40, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
    
    pulsatingLayer.path = circularPath.cgPath
    
    pulsatingLayer.position = CGPoint(x: view.center.x, y: view.frame.height * 0.88)
    
    pulsatingLayer.strokeColor = UIColor.clear.cgColor
    
    pulsatingLayer.fillColor = UIColor(hexString: "0b3142").cgColor
    
    pulsatingLayer.lineCap = .round
    
    pulsatingLayer.strokeEnd = 0
    
    view.layer.addSublayer(pulsatingLayer)
    
}

func animatePulsatingLayer(withPulsatingLayer pulsatingLayer: CAShapeLayer) {
    let animation = CABasicAnimation(keyPath: "transform.scale")
    
    animation.toValue = 1.3
    
    animation.duration = 1.0
    
    animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
    animation.autoreverses = true
    animation.repeatCount = Float.infinity
    
    
    pulsatingLayer.add(animation, forKey: "pulse")
}


func animateStroke(with shapeLayer: inout CAShapeLayer) {
    let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
    
    basicAnimation.toValue = 1.5
    basicAnimation.duration = 1
    basicAnimation.fillMode = .forwards
    basicAnimation.isRemovedOnCompletion = false
    
    shapeLayer.add(basicAnimation, forKey: "strokeAnimation")
}
