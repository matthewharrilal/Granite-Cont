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
        
        containerView.layer.cornerRadius = 20
        
        containerView.anchorSize(toView: self)
        containerView.backgroundColor = UIColor(hexString: "b4c5e4", alpha: 0.5)
        imageView.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: languageName.topAnchor, trailing: containerView.trailingAnchor, padding: .init(top: 10, left: 0, bottom: -5, right: 0))
        imageView.constrainWidth(withWidth: containerView.frame.width)
        imageView.constrainHeight(withHeight: containerView.frame.height / 3)
        
        languageName.anchor(top: imageView.bottomAnchor, leading: containerView.leadingAnchor, bottom: containerView.safeAreaLayoutGuide.bottomAnchor, trailing: containerView.trailingAnchor)
        languageName.constrainWidth(withWidth: containerView.frame.width)
        languageName.constrainHeight(withHeight: containerView.frame.height / 2)
    }
}
