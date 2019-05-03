//
//  PulsatingButton.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 5/3/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit

func configureEnterButton(withPulsatingLayer pulsatingLayer: inout CAShapeLayer, withShapeLayer shapeLayer: inout CAShapeLayer, onView view: UIView) -> (CAShapeLayer, CAShapeLayer) {
    
    let position = CGPoint(x: view.center.x, y: 700)
    
    let circularPath = UIBezierPath(arcCenter: position , radius: 50, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
    
    shapeLayer.path = circularPath.cgPath
    shapeLayer.strokeEnd = 0
    shapeLayer.strokeColor = UIColor(hexString: "98c9a3").cgColor
    shapeLayer.lineWidth = 10
    
    shapeLayer.shadowColor = UIColor.black.cgColor
    shapeLayer.shadowOpacity = 1
    shapeLayer.shadowRadius = 10
    shapeLayer.shadowOffset = .zero
    
    configurePulsatingLayer(onView: view, withPulsatingLayer: pulsatingLayer)
    
    animatePulsatingLayer(withPulsatingLayer: pulsatingLayer)
    
    animateStroke(with: &shapeLayer)
    
    view.layer.addSublayer(shapeLayer)
    
    return (shapeLayer, pulsatingLayer)
}

func configurePulsatingLayer(onView view: UIView, withPulsatingLayer pulsatingLayer:  CAShapeLayer) {
    
    let circularPath = UIBezierPath(arcCenter: .zero , radius: 50, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
    
    pulsatingLayer.path = circularPath.cgPath
    
    pulsatingLayer.position = CGPoint(x: view.center.x, y: 700)
    
    pulsatingLayer.strokeColor = UIColor.clear.cgColor
    
    pulsatingLayer.fillColor = UIColor(hexString: "98c9a3").cgColor
    
    pulsatingLayer.lineCap = .round
    
    pulsatingLayer.strokeEnd = 0
    
    view.layer.addSublayer(pulsatingLayer)
    
}

func animatePulsatingLayer(withPulsatingLayer pulsatingLayer: CAShapeLayer) {
    let animation = CABasicAnimation(keyPath: "transform.scale")
    
    animation.toValue = 1.3
    
    animation.duration = 0.75
    
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
