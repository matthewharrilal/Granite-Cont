//
//  LinksModalView.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 5/30/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit

class LinksModalView: UIView {
    @IBOutlet weak var linkName: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func commonInit() {
        // MARK: TODO Add shadow to container view
        Bundle.main.loadNibNamed("LinksModalView", owner: self, options: nil)
        addSubviews(views: linkName, containerView)
        
        linkName.textAlignment = .center
        
        // MARK: TODO Translation in whole view's Y and alpha 0 initially
        
        containerView.frame = .init(x: self.center.x, y: self.center.y, width: self.frame.width, height: self.frame.height)
        self.backgroundColor = .blue
        containerView.backgroundColor = .white
        
        linkName.constrainHeight(withHeight: self.frame.height - (self.frame.height - 75))
        
        containerView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 75, left: 0, bottom: 0, right: 0))
        
        containerView.layer.cornerRadius = 20
    }
}
