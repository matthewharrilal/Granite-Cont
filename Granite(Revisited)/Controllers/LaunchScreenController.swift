//
//  ViewController.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 4/17/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import UIKit
import Lottie

class LaunchScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configureAnimation()
    }
    
    
    private func configureAnimation() {
        
        let animationView = LOTAnimationView(name: "launchAnimation")
        animationView.contentMode = .scaleAspectFit
        
        self.view.backgroundColor = .clear
        
        animationView.loopAnimation = true
        self.view.addSubview(animationView)
        
        animationView.frame = self.view.bounds
        
        animationView.play { (completed) in
            print("Has completed animation? -> \(completed)")
        }
    }

}

