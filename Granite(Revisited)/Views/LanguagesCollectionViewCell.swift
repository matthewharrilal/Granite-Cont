//
//  LanguagesCollectionViewCell.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 5/29/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit

class LanguagesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var languageName: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("LanguagesCollectionViewCell", owner: self, options: nil)

        containerView.addSubviews(views: imageView, languageName)
        addSubview(containerView)
        
        containerView.anchorSize(toView: self)
        imageView.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: languageName.topAnchor, trailing: containerView.trailingAnchor)
        languageName.anchor(top: imageView.bottomAnchor, leading: containerView.leadingAnchor, bottom: containerView.bottomAnchor, trailing: containerView.trailingAnchor)
    }
}
