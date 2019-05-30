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
    @IBOutlet weak var collectionView: UICollectionView!
    var transitionButton: UIButton!
    
    
    var languagesArray: [(UIImage, String)] = [(#imageLiteral(resourceName: "javascript"), "Javascript"), (#imageLiteral(resourceName: "go"), "Golang"), (#imageLiteral(resourceName: "python"), "Python"), (#imageLiteral(resourceName: "ruby"),"Ruby"), (#imageLiteral(resourceName: "c"), "C++"), (#imageLiteral(resourceName: "java"), "Java"), (#imageLiteral(resourceName: "rust"), "Rust"), (#imageLiteral(resourceName: "php"), "PHP"), (#imageLiteral(resourceName: "swift"), "Swift") ]
    
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
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(LanguagesCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.alpha = 0.0
        preferredLanguageLabel.alpha = 0.0
        descriptionLabel.alpha =  0.0
        preferredLanguageLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 20)
        descriptionLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 17)
//
        
        addSubviews(views: preferredLanguageLabel, descriptionLabel, collectionView)
        collectionView?.contentInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
    }
}

