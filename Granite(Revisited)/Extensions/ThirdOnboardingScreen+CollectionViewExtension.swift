//
//  ThirdOnboardingScreen+CollectionViewExtension.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 5/30/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit

extension ThirdOnboardingScreen: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.imageToColor.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "linkCell", for: indexPath) as! LinksCollectionViewCell
        
        
        cell.containerView.layer.cornerRadius = 25
        cell.containerView.layer.masksToBounds = true
        //
        cell.linkName.text = self.imageName[indexPath.row].0
        cell.linkName.textColor =  self.imageName[indexPath.row].1
        
        cell.linkLogo.image = self.imageToColor[indexPath.row].0
        cell.containerView.backgroundColor = self.imageToColor[indexPath.row].1
        
        
        
        cell.containerView.layer.masksToBounds = true
        
        cell.linkLogo.contentMode = .scaleAspectFit
        
        cell.isExclusiveTouch = true
        cell.containerView.isExclusiveTouch = true
        for child in cell.subviews {
            child.isExclusiveTouch = true
        }
        
        cell.alpha = 0
        cell.transform = CGAffineTransform(translationX: 0, y: cell.bounds.height / 2)
        UIView.animate(withDuration: 1.0, delay: 0.15 * Double(indexPath.row),usingSpringWithDamping: 0.4, initialSpringVelocity: 0.1, options: .curveEaseInOut, animations: {
            
            cell.transform = CGAffineTransform(translationX: 0, y: 0)
            cell.alpha = 1
        }, completion: nil)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //        let lastIndex = indexPath.row == (self.imageToColor.count - 1) ? true : false
        //        let contentOffsetX = collectionView.contentOffset.x
        //
        //        let indiciator = contentOffsetX >= (collectionView.contentSize.width - collectionView.bounds.width) ? true  : false
        //        if indiciator {
        //            self.animateViewScrollClosure?()
        //        }
        
        //        coordinator?.animateTransitionView()
    }
    
    //    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    //        print("Hello")
    //    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        self.coordinator?.animateTransitionView()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // MARK: Fix Everytime view is instatiated new cell is being registered on top
        
        // MARK: TODO Use the modalLinkTapClosure to notify onboarding controller to create the blur view and the modal view
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? LinksCollectionViewCell else {return}
        
        self.indexPathRow = indexPath.row
        
        // SET HERE but being used before set
        self.startingFrame = cell.containerView.superview?.convert(cell.containerView.frame, to: nil)
        
        guard let startingFrame = self.startingFrame else {return}
        self.modalViewTapClosure?(startingFrame, cell.linkName.text)
        
        
        if var image = cell.linkLogo.image {
            
            // Changing contrast of the medium logo against black
            if cell.linkName.text == "Medium" {
                let templateImage = #imageLiteral(resourceName: "mediumLogoBlack")
                image = templateImage
            }
            
            guard let logoImageClosure = self.logoImageClosure else {return}
            
            
            
            logoImageClosure(image, cell.containerView.backgroundColor ?? .red, cell.linkName.text ?? "")
            
            
        }
        
        
    }
   
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
        }
        
        return .init(width: self.frame.width, height: 120)
    }

}
