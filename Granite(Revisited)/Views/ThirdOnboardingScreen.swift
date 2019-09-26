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
//    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var modalViewTapClosure: ((CGRect, String?) -> Void)?
    var logoImageClosure: ((UIImage, UIColor, String) -> Void)?
    
    var transitionButton: UIButton!
    
    var blurViewTapClosure: ((UIView) -> Void)?
    
    var imageToColor:[(UIImage, UIColor)] = [(#imageLiteral(resourceName: "mediumLogo"), .black), (#imageLiteral(resourceName: "twitterLogo"), .init(hexString: "dff2d8")), (#imageLiteral(resourceName: "githubLogo"), .init(hexString: "ffe66d")), (#imageLiteral(resourceName: "linkedinLogo"), UIColor.init(hexString: "91c7b1")), (#imageLiteral(resourceName: "computerClipArt"), .init(hexString: "d7b9d5"))]
    var imageName: [(String, UIColor)] = [("Medium", .white), ("Twitter", .black), ("Github", .black), ("LinkedIn", .black), ("Personal Website", .black) ]
    
    var startingFrame: CGRect?
    var blurView: UIVisualEffectView!
    var didTap = false
    lazy var redView = LinksModalView(frame: startingFrame!)
    var indexPathRow: Int?
    var coordinator: MainCoordinator?
    var animateViewScrollClosure: (() -> Void)?
    var selectedLanguagesClosure: ((Set<String>) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        commonInit()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        commonInit()
    }
    
    override func layoutSubviews() {
        commonInit()
    }
    

    func commonInit() {
        Bundle.main.loadNibNamed("ThirdOnboardingScreen", owner: self, options: nil)
        
        
        // MARK: TODO Change the text here be more concise
        moreAboutYourself.text =  "Tell us more about yourself"
        
        moreAboutYourself.font = UIFont.bold(size: 20)

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(LinksCollectionViewCell.self, forCellWithReuseIdentifier: "linkCell")
        collectionView?.contentInset = UIEdgeInsets(top: 40, left: 16, bottom: 10, right: 16)
        addSubviews(views: moreAboutYourself, collectionView)

        collectionView.anchor(top: self.moreAboutYourself.bottomAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 5, left: 10, bottom: -10, right: -10))

        self.moreAboutYourself.snp.makeConstraints { (make) in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.topMargin).offset(10)
            make.left.equalToSuperview().offset(26)
        }
    }
    
    @objc func handleTap() {
        removeChildViews(views: self.moreAboutYourself, self.collectionView, self.transitionButton)
        let signUpView = SignUpView(frame: self.bounds)
        
        self.addSubview(signUpView)

    }
}


