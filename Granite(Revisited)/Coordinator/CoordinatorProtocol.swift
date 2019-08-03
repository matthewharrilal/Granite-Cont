//
//  CoordinatorProtocol.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 8/3/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] {get set} // For storing properties you have to specify getter/setter properties
    
    var navigationController: UINavigationController {get set}
    
    func start()
}
