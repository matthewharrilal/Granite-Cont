//
//  LogInViewController.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 4/17/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit
import Lottie

class LogInViewController: UIViewController {
    
    var configuredView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        drawArch()
        
        addConfiguredView()
        
        configureAnimation()
        
    }
    
}

