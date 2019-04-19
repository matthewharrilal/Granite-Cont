//
//  LoginView.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 4/17/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit

class LoginView: UIView {
    
    var shapeLayer: CAShapeLayer!
    
    var configuredView: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        
//        addConfiguredView()
        
//        configureAnimation()
    }
    
    private func commonInit() {
        print("Loading login view")
        Bundle.main.loadNibNamed("LoginView", owner: self, options: nil)
    }
}
