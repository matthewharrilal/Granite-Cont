//
//  File.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 6/5/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation


protocol KeyboardDelegate: class {
    func keyboardIsActive()
}


protocol EndEditingDelegate: class {
    func returnWasPressed()
}
