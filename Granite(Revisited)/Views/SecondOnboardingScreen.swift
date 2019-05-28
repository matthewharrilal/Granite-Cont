//
//  SecondOnboardingScreen.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 5/28/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit

class SecondOnboardingScreen: UIView {
    @IBOutlet weak var preferredLanguageLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    fileprivate func commonInit() {
        Bundle.main.loadNibNamed("SecondOnboardingScreen", owner: self, options: nil)
        addSubviews(views: preferredLanguageLabel, descriptionLabel, tableView)
    }
}

