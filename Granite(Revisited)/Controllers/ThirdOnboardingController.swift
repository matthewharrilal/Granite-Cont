//
//  ThirdOnboardingController.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 8/6/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit

class ThirdOnboardingController: UIViewController {
    var thirdOnboardingScreen = ThirdOnboardingScreen()
    var modalViewTapClosure: ((CGRect, String?) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.restorationIdentifier = NSStringFromClass(self.classForCoder)
        self.view.backgroundColor = .white
        
        
    }
    
    override func viewDidLayoutSubviews() {
        layout()
//        self.modalViewTapClosure = thirdOnboardingScreen.modalViewTapClosure
//        print(self.modalViewTapClosure)
        
        thirdOnboardingScreen.modalViewTapClosure = {[weak self] (startingFrame, text) in
//            print(startingFrame, text)
            self?.modalViewTapClosure?(startingFrame, text)
        }
        
//        self.modalViewTapClosure = thirdOnboardingScreen.modalViewTapClosure
    }
}

extension ThirdOnboardingController {
    func layout() {
        layoutThirdOnboardingScreen()
    }
    
    func layoutThirdOnboardingScreen() {
        self.view.addSubview(self.thirdOnboardingScreen)
        thirdOnboardingScreen.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}