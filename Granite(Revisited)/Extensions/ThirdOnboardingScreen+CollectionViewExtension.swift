//
//  ThirdOnboardingScreen+CollectionViewExtension.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 5/30/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit

extension ThirdOnboardingScreen: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
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
        //        if indexPath.row == (self.imageToColor.count - 1) {
        //
        //            UIView.animate(withDuration: 1.0, animations: {
        //                self.transitionButton.alpha = 1
        //                 collectionView.anchor(top: self.descriptionLabel.bottomAnchor, leading: self .leadingAnchor, bottom: self.transitionButton.topAnchor, trailing: self.trailingAnchor, padding: .init(top: 0, left: 10, bottom: -20, right: -10))
        //            }) { _ in
        //
        //            }
//        //        }
//        
//        if collectionView.contentOffset.y >= (collectionView.contentSize.height - collectionView.frame.size.height) {
//            collectionView.anchor(top: self.descriptionLabel.bottomAnchor, leading: self .leadingAnchor, bottom: self.transitionButton.topAnchor, trailing: self.trailingAnchor, padding: .init(top: 0, left: 10, bottom: -20, right: -10))
//            
//            UIView.animate(withDuration: 0.25, animations: {
//                self.transitionButton.alpha = 1
//                self.collectionView.layoutIfNeeded()
//            }) { _ in
//                
//            }
//            print("End of table")
//        }

    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // MARK: Fix Everytime view is instatiated new cell is being registered on top
        
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? LinksCollectionViewCell else {return}
        
        // SET HERE but being used before set
        self.startingFrame = cell.containerView.superview?.convert(cell.containerView.frame, to: nil)
        
        if var image = cell.linkLogo.image {
            
            // Changing contrast of the medium logo against black
            if cell.linkName.text == "Medium" {
                let templateImage = #imageLiteral(resourceName: "mediumLogoBlack")
                image = templateImage
            }
            self.redView.containerView.logoImage = image
        }
        
        
        //        var redView = LinksModalView(frame: startingFrame!)
        let blurEffect = UIBlurEffect(style: .prominent)
        self.blurView = UIVisualEffectView(effect: blurEffect)
        self.blurView.frame = self.bounds
        self.addSubview(self.blurView)
        self.blurView.alpha = 0.0
        self.blurView.contentView.addSubview(redView)
        redView.layer.cornerRadius = 20
        self.redView.createExitButton()
        
        // For when modal view comes up
        self.redView.containerView.usernameTextField.text = nil
        self.redView.containerView.usernameTextField.resignFirstResponder()
        //        redView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissModal(sender:))))
        
        if let linkNameText = cell.linkName.text {
            self.redView.containerView.linkName = linkNameText
            if linkNameText == "Personal Website" {
                self.redView.containerView.placeholderLabel.text = "Personal Website Link"
                self.redView.containerView.usernameTextField.placeholder = "Personal Website Link"
            }
        }
        
        
        // BLUR OUT Background
        redView.alpha = 0.0
        self.blurView.backgroundColor = cell.containerView.backgroundColor
        self.redView.exitButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissModal(sender:))))
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.7, options: .curveEaseIn, animations: {
             
            // Frame is the same before and after
            // Because the container view no longer has a frame when you resize the red views frame therefore off balancing undefined frame subviews
            self.redView.frame = .init(x: self.center.x, y: self.center.y, width: self.bounds.width / 1.3, height: self.bounds.height / 2.8)
            self.redView.center = self.center
            self.blurView.alpha = 1.0
            self.redView.alpha = 1.0
            self.redView.linkName.constrainWidth(withWidth: self.redView.frame.width - 40)
            
            // CONTAINER VIEW FRAME CHANGING AND NOT SUPERVIEW CHANGING BOUNDS MID X CHANGING AFTER WHAT
            self.redView.layoutSubviews() // Update layout of subviews once the red views frame changes updates the new bounds
            self.redView.containerView.logoImageView.frame.origin.x = self.redView.containerView.frame.minX
            self.redView.containerView.textFieldView.frame.origin.x = self.redView.containerView.logoImageView.center.x
            self.redView.containerView.textFieldView.frame.origin.y = self.redView.containerView.bounds.midY
            
        }, completion: nil)
        
        print("")
        
    }
    
    @objc func dismissModal(sender: UITapGestureRecognizer) {
        self.isUserInteractionEnabled = false
        
        guard let startingFrame = self.startingFrame else {return}
        
        self.blurView.layer.cornerRadius = 20
        
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
//            sender.view?.superview?.frame = startingFrame
            self.blurView.frame = startingFrame
            self.blurView.alpha = 0.0
//            sender.view?.alpha = 0.0
            
        }) { (_) in
            
            // Making sure that views have been removed MARK: FIX make sure that references of these views are deallocated as well
//            sender.view?.superview?.removeFromSuperview()
            self.blurView.removeFromSuperview()
            print("Blur view removed")
            self.isUserInteractionEnabled = true
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
        }
        
        return .init(width: self.frame.width, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
