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
    var logoImage = UIImage() {
        didSet {
            logoImageView.image = logoImage
        }
    }
    
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
        
        self.logoImageView.frame = .init(x: 0, y: 20, width: self.frame.width / 2, height: 75)
    }
    
    // PRO TIP: The reason we dont constrain size is because we need to know the exact x and y when since the frame changes we don't know for sure
    override func layoutIfNeeded() {
//        DispatchQueue.main.async {
//            self.logoImageView.frame = self.bounds
//            self.logoImageView.center.x = self.bounds.midX
//            self.logoImageView.constrainHeight(withHeight: 50)
//            self.logoImageView.constrainWidth(withWidth: 100)
//        }
       
    }
}
