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
    }
}

// Factory Extension
extension CreateAccountViewController {
    func createAccountView() -> CreateAccountView {
        let createAccountView = CreateAccountView()
        createAccountView.backgroundColor = UIColor(hexString: "ccccff")
        
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
