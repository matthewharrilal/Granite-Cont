//
//  SecondOnboardingController.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 5/30/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class SecondOnboardingController: UIViewController {
    // In charge of handling transition buttons tap
    lazy var secondOnboardingScreen = SecondOnboardingScreen()
    var selectedLanguagesClosure: ((Set<String>) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(secondOnboardingScreen)
        
        self.restorationIdentifier = NSStringFromClass(self.classForCoder)
        secondOnboardingScreen.backgroundColor = .white
        secondOnboardingScreen.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        secondOnboardingScreen.selectedLanguagesClosure = self.selectedLanguagesClosure
    }
    
    @objc func handleTap() {
        print(secondOnboardingScreen.languageSet)
    }
}
