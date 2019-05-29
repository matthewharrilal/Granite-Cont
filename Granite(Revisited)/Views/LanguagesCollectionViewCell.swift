//
//  LanguagesCollectionViewCell.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 5/28/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit

class LanguagesCollectionViewCell: UICollectionViewCell {
    var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel = UILabel(frame: self.frame)
        
        titleLabel.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 10, left: 10, bottom: -10, right: -10), size: .init(width: self.frame.width, height: self.frame.height / 2))
        
    }
}
