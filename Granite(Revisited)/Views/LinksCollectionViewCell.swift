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
        self.addSubview(containerView)
        
        let stackView = UIStackView(arrangedSubviews: [linkName, linkLogo])
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        stackView.alignment = .center
        
        containerView.addSubview(stackView)

        stackView.anchorSize(toView: containerView)
        stackView.frame = containerView.frame
        
        
        
        containerView.layer.cornerRadius = 20
        containerView.layer.masksToBounds = true
        
        containerView.anchor(top: self.safeAreaLayoutGuide.topAnchor, leading: self.safeAreaLayoutGuide.leadingAnchor, bottom: self.safeAreaLayoutGuide.bottomAnchor, trailing: self.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 10, left: 10, bottom: -10, right: -10))
        
        containerView.constrainHeight(withHeight: self.frame.height)
        
        containerView.addSubviews(views: linkName, linkLogo)
        
        
//        linkName.constrainWidth(withWidth: containerView.frame.width / 2)
//        linkLogo.constrainWidth(withWidth: containerView.frame.width / 3)
        
        linkName.anchor(top: containerView.safeAreaLayoutGuide.topAnchor, leading: containerView.safeAreaLayoutGuide.leadingAnchor, bottom: containerView.safeAreaLayoutGuide.bottomAnchor, trailing: linkLogo.safeAreaLayoutGuide.leadingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 0))
        
        linkLogo.anchor(top: containerView.safeAreaLayoutGuide.topAnchor, leading: linkName.safeAreaLayoutGuide.trailingAnchor, bottom: containerView.safeAreaLayoutGuide.bottomAnchor, trailing: containerView.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 0))
        
        // Have constraints on positioning now constrain widths
        linkName.constrainWidth(withWidth: self.frame.width / 2)
        linkLogo.constrainWidth(withWidth: self.frame.width / 2)
        
        containerView.backgroundColor = .yellow
        
    }
}
