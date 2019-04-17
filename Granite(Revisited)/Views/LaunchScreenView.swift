//
//  LaunchScreenView.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 4/17/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit
import Lottie

class LaunchScreenView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAnimation()
        print("Entering here")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureAnimation()
    }
    
    private func configureAnimation() {
        Bundle.main.loadNibNamed("LaunchScreenView", owner: self, options: nil)
        
        let animationView = LOTAnimationView(name: "launchAnimation")
        animationView.contentMode = .center
        
        animationView.loopAnimation = true
        self.addSubview(animationView)
        
        animationView.frame = self.bounds
        
        animationView.play { (completed) in
            print("Has completed animation? -> \(completed)")
        }
    }
}
