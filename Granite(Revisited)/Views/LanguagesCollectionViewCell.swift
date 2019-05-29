//
//  LanguagesCollectionViewCell.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 5/29/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit

class LanguagesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var languageName: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("LanguagesCollectionViewCell", owner: self, options: nil)
        addSubviews(views: languageName, imageView)
    }
}
