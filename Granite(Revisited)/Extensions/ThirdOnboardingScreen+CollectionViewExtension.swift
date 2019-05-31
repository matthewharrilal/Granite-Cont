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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "linkCell", for: indexPath) as! LinksCollectionViewCell
        
        cell.containerView.layer.cornerRadius = 25
        cell.containerView.layer.masksToBounds = true
//
        cell.linkName.text = self.imageName[indexPath.row].0
        cell.linkName.textColor =  self.imageName[indexPath.row].1

        cell.linkLogo.image = self.imageToColor[indexPath.row].0
        cell.containerView.backgroundColor = self.imageToColor[indexPath.row].1
        
        cell.linkLogo.contentMode = .scaleAspectFit

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? LinksCollectionViewCell else {return}
        print("Link chosen \(cell.linkName.text)")
        
        self.startingFrame = cell.containerView.superview?.convert(cell.containerView.frame, to: nil)
        
        let redView = UIView(frame: startingFrame!)
        redView.backgroundColor = .red
        redView.layer.cornerRadius = 20
        
        redView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissModal(sender:))))
        
        
        // BLUR OUT Background
        let blurEffect = UIBlurEffect(style: .prominent)
        self.blurView = UIVisualEffectView(effect: blurEffect)
        self.blurView.frame = self.frame
        self.blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(self.blurView)
        self.blurView.alpha = 0.0
        redView.alpha = 0.0
        self.blurView.contentView.addSubview(redView)
        
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            redView.frame = .init(x: self.center.x, y: self.center.y, width: self.frame.width / 1.5, height: self.frame.height / 2)
            redView.center = self.center
            self.blurView.alpha = 1.0
            redView.alpha = 1.0
            
        }) { (_) in
            print("")
        }
    }
    
    @objc func dismissModal(sender: UITapGestureRecognizer) {
        guard let startingFrame = self.startingFrame else {return}
        self.blurView.layer.cornerRadius = 20
        
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            sender.view?.frame = startingFrame
            self.blurView.frame = startingFrame
            self.blurView.alpha = 0.0
            sender.view?.alpha = 0.0
        }) { (_) in
            print("")
            sender.view?.removeFromSuperview()
            self.blurView.removeFromSuperview()
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
