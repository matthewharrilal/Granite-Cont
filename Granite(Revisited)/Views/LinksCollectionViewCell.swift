//
//  LinksCollectionViewCell.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 5/30/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit

class LinksCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var linkName: UILabel!
    @IBOutlet weak var linkLogo: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("LinksCollectionViewCell", owner: self, options: nil)
        addSubview(containerView)
        
        let stackView = UIStackView(arrangedSubviews: [linkName, linkLogo])
        
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        
        linkName.constrainWidth(withWidth: self.frame.width / 2)
        linkLogo.constrainWidth(withWidth: self.frame.width / 3)
        
        containerView.addSubview(stackView)
        
        stackView.anchorSize(toView: containerView)
        containerView.anchorSize(toView: self)
    }
}
