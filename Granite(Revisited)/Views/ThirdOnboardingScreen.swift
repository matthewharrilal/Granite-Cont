//
//  ThirdOnboardingScreen.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 5/30/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit

class ThirdOnboardingScreen: UIView {
    @IBOutlet weak var moreAboutYourself: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("ThirdOnboardingScreen", owner: self, options: nil)
        addSubviews(views: moreAboutYourself, descriptionLabel, collectionView)
        
        // MARK: TODO Change the text here be more concise
        moreAboutYourself.text =  "Tell us more about yourself"
        descriptionLabel.text = "Provide some useful links to help developers get to know you better"
        
        collectionView.register(LinksCollectionViewCell.self, forCellWithReuseIdentifier: "linkCell")
    }
}


