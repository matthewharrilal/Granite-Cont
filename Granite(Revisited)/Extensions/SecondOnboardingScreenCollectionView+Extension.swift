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
    // MARK: TODO Collection View shadow and cell shadow VERY SUBTLE ... LIGHTER BLUE ON SELECTED CELLS
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return languagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LanguagesCollectionViewCell
        cell.languageName.text = languagesArray[indexPath.row].1
        cell.imageView.image = languagesArray[indexPath.row].0
        cell.imageView.backgroundColor = .clear
   
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 30)) / 2
        return CGSize(width: itemSize, height: itemSize - 10)
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
        guard let cell = collectionView.cellForItem(at: indexPath) as? LanguagesCollectionViewCell,
            let text = cell.languageName.text
            else {return}
        print("Tapping on collection view cell")
        
        if self.languageSet.contains(text) {
            self.languageSet.remove(text)
        }
        
        else {
            self.languageSet.insert(text)
        }
        
        UIView.animate(withDuration: 0.25) {
            let color = cell.containerView.backgroundColor == UIColor(hexString: "4790e6") ? UIColor(hexString: "b4c5e4", alpha: 0.5) : UIColor(hexString: "4790e6")
            let textColor = cell.languageName.textColor == UIColor.white ? UIColor.black: UIColor.white
            
            cell.containerView.backgroundColor = color
            cell.languageName.textColor = textColor
        }
        
        
        
        self.selectedLanguagesClosure?(languageSet)
        
    }
}
