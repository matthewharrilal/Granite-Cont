//
//  LinksModalContainerView.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 6/1/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit

class LinksModalContainerView: UIView {
    @IBOutlet weak var logoImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    fileprivate func commonInit() {
        Bundle.main.loadNibNamed("LinksModalContainerView", owner: self, options: nil)
        addSubview(logoImageView)
        self.logoImageView.image = #imageLiteral(resourceName: "go")
        self.logoImageView.frame = .init(x: 0, y: 0, width: 100, height: 50)
    }
    
    override func layoutIfNeeded() {
//        DispatchQueue.main.async {
//            self.logoImageView.frame = self.bounds
//            self.logoImageView.center.x = self.bounds.midX
//            self.logoImageView.constrainHeight(withHeight: 50)
//            self.logoImageView.constrainWidth(withWidth: 100)
//        }
       
    }
}
