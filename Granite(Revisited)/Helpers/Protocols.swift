//
//  File.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 6/5/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation



protocol EndEditingDelegate: class {
    func returnWasPressed(linkText: String)
}

protocol DismissModalViewDelegate: class {
    func successHasPlayed()
}

protocol RelayLinkText: class {
    func relayLinkText(linkText: String)
}
