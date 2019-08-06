//
//  TouchableBouncView.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 8/3/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit

protocol TouchableView {
    var tapGesture: UITapGestureRecognizer?
    var selectBlock: (() -> Void)?
}

class TouchableBounceView: UIView {
    var tapGesture: UITapGestureRecognizer?
    var item: Any?
    
    // Does this didSet functionality get called after this selectBlock closure is allocated and before its called?
    var selectBlock: (() -> Void)? {
        didSet {
            guard self.tapGesture == nil else {return}
            
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(pressed))
            self.addGestureRecognizer(tapGestureRecognizer)
            self.tapGesture = tapGestureRecognizer
        }
    }
    
    // Because techinically this should not be executed until gesture is added however to get in there select block needs to be triggered
    @objc func pressed() {
        print("Button has been pressed")
        self.selectBlock?()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        UIView.animate(withDuration: 0.22, delay: 0, options: [.allowUserInteraction], animations: {
            self.alpha = 0.9
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }, completion: nil)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        UIView.animate(withDuration: 0.22, delay: 0, options: [.allowUserInteraction], animations: {
            self.alpha = 1
            self.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        UIView.animate(withDuration: 0.22, delay: 0, options: [.allowUserInteraction], animations: {
            self.alpha = 1
            self.transform = CGAffineTransform.identity
        }, completion: nil)
    }
}


class TouchableCollectionViewCell: UICollectionViewCell, TouchableView {
    var tapGesture: UITapGestureRecognizer?
    
    var selectBlock: (() -> Void)? {
        didSet {
            
            // The first time since the tap gesture hasn't been set does this provide the early exit and does it get executed
            guard tapGesture == nil else {return}
            
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
            self.addGestureRecognizer(tapGestureRecognizer)
            self.tapGesture = tapGestureRecognizer
        }
    }
    
    @objc func handleTap() {
        self.selectBlock?()
    }
}
