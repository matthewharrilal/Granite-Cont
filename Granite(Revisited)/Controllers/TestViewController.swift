//
//  TestViewController.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 8/5/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit

class TestViewController: UIViewController {
    // Used to test the embedding of a page view controller
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let controller = OnboardingPageViewController()
        self.addChild(controller)
        
        self.view.addSubview(controller.view)
        
        self.view.backgroundColor = .blue
        
        controller.view.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            
            make.bottom.equalToSuperview().offset(-100)
        }
    }
    
}
