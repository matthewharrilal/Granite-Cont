//
//  UIFont+Extension.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 8/3/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit

extension UIFont{
    
    static func regular(size fontSize:CGFloat = 17)->UIFont{
        return UIFont(name: "Poppins-Regular", size: fontSize)!
    }
    
    static func medium(size fontSize:CGFloat = 17)->UIFont{
        return UIFont(name: "Poppins-Medium", size: fontSize)!
    }
    
    static func bold(size fontSize:CGFloat = 17)->UIFont{
        return UIFont(name: "Poppins-Bold", size: fontSize)!
    }
    
    static func extraBold(size fontSize:CGFloat = 17)->UIFont{
        return UIFont(name: "Poppins-Extrabold", size: fontSize)!
    }
    
    
    static func semiBold(size fontSize:CGFloat = 17)->UIFont{
        return UIFont(name: "Poppins-Semibold", size: fontSize)!
    }
}
