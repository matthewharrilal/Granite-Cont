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
        
        // MARK: FIX Display animation then transition to initial view of the screen
        configureAnimation()
    }
    
    
    private func configureAnimation() {
        self.view.backgroundColor = UIColor(hexString: "c9ddff")

        let animationView = LOTAnimationView(name: "launchAnimation")
        animationView.contentMode = .scaleAspectFit
        
        
        animationView.loopAnimation = true
        self.view.addSubview(animationView)
        
        animationView.frame = self.view.bounds
        
        animationView.play { (completed) in
            print("Has completed animation? -> \(completed)")
        }
    }

}

