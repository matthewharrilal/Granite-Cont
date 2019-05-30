//
//  SecondOnboardingScreenTableView+Extension.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 5/28/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit

extension SecondOnboardingScreen: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LanguagesCollectionViewCell
        cell.languageName.text = "Swift"
//        let templateImage = #imageLiteral(resourceName: "swiftLogo").withRenderingMode(.alwaysTemplate)
        cell.imageView.image = #imageLiteral(resourceName: "swiftLogo")
        return cell
    }
    //
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 20)) / 2
        return CGSize(width: itemSize, height: itemSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
        guard let cell = collectionView.cellForItem(at: indexPath) as? LanguagesCollectionViewCell else {return}
        print("Tapping on collection view cell")
        
        UIView.animate(withDuration: 0.25) {
            let color = cell.containerView.backgroundColor == UIColor.blue ? UIColor(hexString: "b4c5e4", alpha: 0.5) : UIColor.blue
            let textColor = cell.languageName.textColor == UIColor.white ? UIColor.black: UIColor.white
            let originalColor = cell.imageView.tintColor
//            let tintColor = cell.imageView.tintColor == UIColor.white ? originalColor: UIColor.white
//            cell.imageView.tintColor = tintColor
            cell.containerView.backgroundColor = color
            cell.languageName.textColor = textColor
        }
    }
}
