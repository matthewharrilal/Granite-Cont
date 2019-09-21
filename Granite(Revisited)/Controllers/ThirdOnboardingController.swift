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
    var animateViewScrollClosure: (() -> Void)?
    var logoImageClosure: ((UIImage) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.restorationIdentifier = NSStringFromClass(self.classForCoder)
        self.view.backgroundColor = .white
        
    }
    
    override func viewDidLayoutSubviews() {
        layout()
        
        thirdOnboardingScreen.logoImageClosure = self.logoImageClosure
        thirdOnboardingScreen.modalViewTapClosure = self.modalViewTapClosure
        thirdOnboardingScreen.animateViewScrollClosure = {[weak self] in
            UIView.animate(withDuration: 2.0, animations: {
                self?.thirdOnboardingScreen.transitionButton.alpha = 0.0
            })
        }

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
