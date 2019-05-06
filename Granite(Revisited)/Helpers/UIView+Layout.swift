//
//  UIView+Layout.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 5/6/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        // Enables auto layout
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    func anchorSize(toView view: UIView) {
        widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
    }
    
    func fillSuperview(withSuperview superview: UIView, padding: UIEdgeInsets = .zero) {
        // Enables autolayout
        translatesAutoresizingMaskIntoConstraints = false
        
        
        // Constrain the top anchor of the view that is currently calling this method
        topAnchor.constraint(equalTo: superview.topAnchor, constant: padding.top).isActive = true
        
        leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: padding.left).isActive = true
        
        trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: padding.right).isActive = true
        
        bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: padding.bottom).isActive = true
        
    }
    
    func centerInSuperview(withSize size: CGSize = .zero) {
        // Constrains elements to center and constrains the size configurations to the view's superview
        translatesAutoresizingMaskIntoConstraints = false
        
        if let superviewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superviewCenterXAnchor).isActive = true
        }
        
        if let superviewCenterYAnchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: superviewCenterYAnchor).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    func centerXInSuperview(toSuperview superview: UIView?=nil) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let superviewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superviewCenterXAnchor).isActive = true
        }
    }
    
    
    func centerYInSuperview(toSuperview superview: UIView?=nil) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let superviewYAnchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: superviewYAnchor).isActive = true
        }
    }
    
    func constrainWidth(withWidth width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func constrainHeight(withHeight height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
}

