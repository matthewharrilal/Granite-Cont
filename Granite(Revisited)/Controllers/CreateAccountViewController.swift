//
//  CreateAccountViewControllerr.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 8/3/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit


class CreateAccountViewController: UIViewController {
    
    lazy var accountView: CreateAccountView = self.createAccountView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        print(self.accountView.emailTextField.allTargets)
        
        self.accountView.tapClosure = {[weak self] in
            self?.animateEmailView()
        }
    }
    
    
    func animateEmailView() {
        UIView.animate(withDuration: 1.0) {
            self.accountView.emailTextField.placeholder = ""
            self.accountView.emailPlaceholderLabel.alpha = 0.8
            
            animateViewBorder(withBorder: &self.accountView.bottomBorder)
        }
    }
    
    
}

// Factory Extension
extension CreateAccountViewController {
    func createAccountView() -> CreateAccountView {
        let createAccountView = CreateAccountView()
        createAccountView.backgroundColor = UIColor(hexString: "ccddfc")
        
        //        createAccountView.emailTextField.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        
        return createAccountView
    }
    
    
}

// Layout Extension
extension CreateAccountViewController {
    func layout() {
        self.view.backgroundColor = .white
        layoutAccountView()
    }
    
    func layoutAccountView() {
        self.view.addSubview(self.accountView)
        
        accountView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}


