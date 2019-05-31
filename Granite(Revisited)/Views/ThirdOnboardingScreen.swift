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
    var transitionButton: UIButton!
    var imageToColor:[(UIImage, UIColor)] = [(#imageLiteral(resourceName: "mediumLogo"), .black), (#imageLiteral(resourceName: "githubLogo"), .init(hexString: "ffe66d")), (#imageLiteral(resourceName: "twitterLogo"), .init(hexString: "dff2d8"))]
    var imageName: [(String, UIColor)] = [("Medium", .white), ("Github", .black), ("Twitter", .black)]
    var startingFrame: CGRect?
    var blurView: UIVisualEffectView!
    var didTap = false
    lazy var redView = LinksModalView(frame: startingFrame!)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("ThirdOnboardingScreen", owner: self, options: nil)
        addSubviews(views: moreAboutYourself, descriptionLabel, collectionView)
        
        // MARK: TODO Change the text here be more concise
        moreAboutYourself.text =  "Tell us more about yourself"
        descriptionLabel.text = "Provide some useful links to help developers get to know you better"
        
        collectionView.delegate = self
        collectionView.dataSource = self
//        collectionView.backgroundColor = .red
        collectionView.register(LinksCollectionViewCell.self, forCellWithReuseIdentifier: "linkCell")
        collectionView?.contentInset = UIEdgeInsets(top: 40, left: 16, bottom: 10, right: 16)
    }
}

