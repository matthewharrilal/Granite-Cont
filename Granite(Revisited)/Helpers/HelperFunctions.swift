//
//  HelperFunctions.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 5/29/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit

func createLabelSpacing(withLabelText labelText: String) -> NSMutableAttributedString {
    let paragraph = NSMutableParagraphStyle()
    paragraph.lineSpacing = 15
    
    let attributedString = NSMutableAttributedString(string: labelText)
    
    attributedString.addAttribute(.paragraphStyle, value: paragraph, range: NSMakeRange(0, attributedString.length))
    
    return attributedString
}
